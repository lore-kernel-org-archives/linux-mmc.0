From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH v1 1/4] mmc: core: Add trace event for SD SCR response
Date: Tue, 16 Apr 2019 12:36:59 +0000
Message-ID: <SN6PR04MB492517B439F0E5CB8F3CDC07FC240@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190415225241.70088-1-rrangel@chromium.org>
 <20190415193133.2cdbc6d0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415193133.2cdbc6d0@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, Raul E Rangel <rrangel@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-trace-devel@vger.kernel.org" <linux-trace-devel@vger.kernel.org>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "zwisler@chromium.org" <zwisler@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

>=20
> On Mon, 15 Apr 2019 16:52:38 -0600
> Raul E Rangel <rrangel@chromium.org> wrote:
>=20
> > Example:
> > sd_scr: mmc0: version: 2, spec3: 1, width: 5, cmds: 0, raw: {0x2b58000,=
0x0}
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> >
> >  drivers/mmc/core/sd.c      |  4 ++++
> >  include/trace/events/mmc.h | 42
> ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 265e1aeeb9d8..3bed7c4b6d75 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -21,6 +21,8 @@
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/mmc/sd.h>
> >
> > +#include <trace/events/mmc.h>
> > +
> >  #include "core.h"
> >  #include "card.h"
> >  #include "host.h"
> > @@ -200,6 +202,7 @@ static int mmc_decode_scr(struct mmc_card *card)
> >  	if (scr_struct !=3D 0) {
> >  		pr_err("%s: unrecognised SCR structure version %d\n",
> >  			mmc_hostname(card->host), scr_struct);
> > +		trace_sd_scr(card, NULL);
> >  		return -EINVAL;
> >  	}
> >
> > @@ -221,6 +224,7 @@ static int mmc_decode_scr(struct mmc_card *card)
> >
> >  	if (scr->sda_spec3)
> >  		scr->cmds =3D UNSTUFF_BITS(resp, 32, 2);
> > +	trace_sd_scr(card, scr);
> >  	return 0;
> >  }
> >
> > diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
> > index 7b706ff21335..e45258e8a6cb 100644
> > --- a/include/trace/events/mmc.h
> > +++ b/include/trace/events/mmc.h
> > @@ -10,6 +10,48 @@
> >  #include <linux/mmc/host.h>
> >  #include <linux/tracepoint.h>
> >
> > +TRACE_EVENT(sd_scr,
As all 3 new trace events (csd, scr, and ssr) are pretty close,
You might want to find a common ground and declare an event class.

Thanks,
Avri

> > +
> > +	TP_PROTO(struct mmc_card *card, struct sd_scr *scr),
> > +
> > +	TP_ARGS(card, scr),
> > +
> > +	TP_STRUCT__entry(
> > +		__array(u32,			raw,	2)
> > +		__field(unsigned char,		sda_vsn)
> > +		__field(unsigned char,		sda_spec3)
> > +		__field(unsigned char,		bus_widths)
> > +		__field(unsigned char,		cmds)
> > +		__string(name,			mmc_hostname(card->host))
> > +	),
> > +
> > +	TP_fast_assign(
> > +		memcpy(__entry->raw, card->raw_scr, sizeof(card-
> >raw_scr));
>=20
> Having the memcpy() size be that of the source is dangerous. Not that
> the destination will every be smaller, but I would highly suggest
> either trying to see if "sizeof(__entry->raw)" works or at worse,
> sizeof(u32)*2.
>=20
> -- Steve
>=20
> > +		if (scr) {
> > +			__entry->sda_vsn =3D scr->sda_vsn;
> > +			__entry->sda_spec3 =3D scr->sda_spec3;
> > +			__entry->bus_widths =3D scr->bus_widths;
> > +			__entry->cmds =3D scr->cmds;
> > +		} else {
> > +			__entry->sda_vsn =3D 0;
> > +			__entry->sda_spec3 =3D 0;
> > +			__entry->bus_widths =3D 0;
> > +			__entry->cmds =3D 0;
> > +		}
> > +		__assign_str(name, mmc_hostname(card->host));
> > +	),
> > +
> > +	TP_printk("%s: version: %d, spec3: %d, width: %d, cmds: %d, "
> > +		"raw: %s",
> > +		  __get_str(name),
> > +		  __entry->sda_vsn,
> > +		  __entry->sda_spec3,
> > +		  __entry->bus_widths,
> > +		  __entry->cmds,
> > +		  __print_array(__entry->raw, 2, sizeof(u32))
> > +	)
> > +);
> > +
> >  TRACE_EVENT(mmc_request_start,
> >
> >  	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
