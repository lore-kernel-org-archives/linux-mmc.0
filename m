From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: add device class attribute for ext_csd
Date: Tue, 27 Jul 2010 16:20:13 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E417C54@dbde02.ent.ti.com>
References: <20100726100956.GA17996@july> <4C4D6BF9.1040704@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6@dbde02.ent.ti.com>
 <4C4D82C8.3040307@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E4177BD@dbde02.ent.ti.com>
 <4C4E9002.5020808@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47134 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab0G0Kux convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jul 2010 06:50:53 -0400
In-Reply-To: <4C4E9002.5020808@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Tuesday, July 27, 2010 1:22 PM
> To: Ghorai, Sukumar
> Cc: linux-mmc@vger.kernel.org; Andrew Morton
> Subject: Re: [PATCH] mmc: add device class attribute for ext_csd
> 
> Ghorai, Sukumar wrote:
> >
> >> -----Original Message-----
> >> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> >> Sent: Monday, July 26, 2010 6:13 PM
> >> To: Ghorai, Sukumar
> >> Cc: linux-mmc@vger.kernel.org; Andrew Morton
> >> Subject: Re: [PATCH] mmc: add device class attribute for ext_csd
> >>
> >> Ghorai, Sukumar wrote:
> >>> All,
> >>> EXT_CSD is 512byte information (read using CMD8) for the MMC (eMMC)
> >> device.
> >>> And for the latest and upcoming specification, ext_csd are much
> relevant
> >> then past.
> >>> So please let me know your idea to add and get the same ext_csd as MMC
> >> device attribute. This is the same way currently available for csd, cid,
> >> src, etc.
> >>> (# cat /sys/class/mmc_host/mmc1/mmc1\:0001/ext_csd)
> >> Some of the values in Extended CSD can change so storing
> >> it could cause incorrect values to be reported.
> > [Ghorai] I was thinking to get the original value as reference, such
> that we know that host is capable for maximum negotiation, like 8-bit, DDR
> mode, voltage, etc.
> > 1. Is there any other way to get the original value supported by card?
> > 2. If yes, is it worth full to do?
> 
> If it is for debugging, would a debug prints do instead e.g.
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89f7a25..cba87b0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -249,6 +249,9 @@ static int mmc_read_ext_csd(struct mmc_card *card)
>                                         1 << ext_csd[EXT_CSD_S_A_TIMEOUT];
>         }
> 
> +       pr_debug("%s: initial ext_csd bus width code %02x",
> +                mmc_hostname(host), ext_csd[EXT_CSD_BUS_WIDTH]);
> +
[Ghorai] yes, we need this kind messages in some format.
So let me add some more important debug print message(s) from ext_csd and submit as a patch.

>  out:
>         kfree(ext_csd);
> 
> 
> 
> >
> >> Note that Extended CSD is available via debugfs
> >> e.g. for device mmc0:0001 with debugfs mounted on /sys/kernel/debug
> >>
> >>     cat /sys/kernel/debug/mmc0/mmc0\:0001/ext_csd
> > [Ghorai] Thanks. I got it.
> >
> > <<snip>>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

