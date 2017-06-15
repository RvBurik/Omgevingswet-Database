alter table vergunning
add constraint CHK_JEHB_VERGUNNI check (
	(
		(status = 'Aangevraagd') and datumuitgave is null and datumverloop is null
	) or (
		status = 'Afgewezen'
	) or (
		(status = 'Uitgegeven' or status = 'Bezwaar')
		and (datumuitgave is not null)
		and (( datumverloop > datumuitgave) or datumverloop is null)
	) or (
		status = 'Verlopen' and datumverloop > datumuitgave and datumuitgave is not null and datumverloop is not null
	)
)
go

alter table vergunning
add constraint CHK_RGERJH_VERGUNNI check (
	(
		datumverloop is null and datumuitgave is null
	) or (
		(
			(
				datumverloop is not null and datumuitgave is not null
				and datumverloop > datumuitgave
			) or (
				datumverloop is null and datumuitgave is not null
			)
		) and (
			datumuitgave > datumaanvraag
		)
	)
)
go
