From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2 1/8] mmc: omap: Enable Auto CMD12
Date: Fri, 16 Mar 2012 19:56:58 +0530
Message-ID: <CANfBPZ_XHj0G8KbFzWJZGsRLnNHawAreQUmwwskMB4xpMxGmnQ@mail.gmail.com>
References: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
 <1331905144-31655-2-git-send-email-svenkatr@ti.com> <20120316135113.GM24651@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:49425 "HELO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S965200Ab2CPO1U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Mar 2012 10:27:20 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg15so4387219bkc.34
        for <linux-mmc@vger.kernel.org>; Fri, 16 Mar 2012 07:27:18 -0700 (PDT)
In-Reply-To: <20120316135113.GM24651@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com

On Fri, Mar 16, 2012 at 7:21 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Mar 16, 2012 at 07:08:57PM +0530, Venkatraman S wrote:
>> From: Balaji T K <balajitk@ti.com>
>>
>> Enable Auto-CMD12 for multi block read/write on HSMMC
>> Tested on OMAP4430, OMAP3430 and OMAP2430 SDP
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 16 +++++++++++++---
>> =A01 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index f29e1a2..a9ffd70 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -85,6 +85,7 @@
>> =A0#define BRR_ENABLE =A0 =A0 =A0 =A0 =A0 (1 << 5)
>> =A0#define DTO_ENABLE =A0 =A0 =A0 =A0 =A0 (1 << 20)
>> =A0#define INIT_STREAM =A0 =A0 =A0 =A0 =A0(1 << 1)
>> +#define ACEN_ACMD12 =A0 =A0 =A0 =A0 =A0(1 << 2)
>> =A0#define DP_SELECT =A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
>> =A0#define DDIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
>> =A0#define DMA_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>> @@ -115,6 +116,7 @@
>> =A0#define OMAP_MMC_MAX_CLOCK =A0 52000000
>> =A0#define DRIVER_NAME =A0 =A0 =A0 =A0 =A0"omap_hsmmc"
>>
>> +#define AUTO_CMD12 =A0 =A0 =A0 =A0 =A0 (1 << 0) =A0 =A0 =A0 =A0/* A=
uto CMD12 support */
>> =A0/*
>> =A0 * One controller can have multiple slots, like on some omap boar=
ds using
>> =A0 * omap.c controller driver. Luckily this is not currently done o=
n any known
>> @@ -175,6 +177,7 @@ struct omap_hsmmc_host {
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs_blocked=
;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_reg;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_in_progr=
ess;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0flags;
>> =A0 =A0 =A0 struct omap_hsmmc_next =A0next_data;
>>
>> =A0 =A0 =A0 struct =A0omap_mmc_platform_data =A0*pdata;
>> @@ -766,6 +769,8 @@ omap_hsmmc_start_command(struct omap_hsmmc_host =
*host, struct mmc_command *cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdtype =3D 0x3;
>>
>> =A0 =A0 =A0 cmdreg =3D (cmd->opcode << 24) | (resptype << 16) | (cmd=
type << 22);
>> + =A0 =A0 if ((host->flags & AUTO_CMD12) && mmc_op_multi(cmd->opcode=
))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmdreg |=3D ACEN_ACMD12;
>>
>> =A0 =A0 =A0 if (data) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdreg |=3D DP_SELECT | MSBS | BCE;
>> @@ -837,11 +842,15 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *h=
ost, struct mmc_data *data)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->bytes_xfered =3D 0;
>>
>> - =A0 =A0 if (!data->stop) {
>> + =A0 =A0 if (data->stop && ((!(host->flags & AUTO_CMD12)) || data->=
error)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_start_command(host, data->stop,=
 NULL);
>> + =A0 =A0 }
>> + =A0 =A0 else {
>
> while adding the braces, you broke the coding style. Please fix.
>

Oops - now fixed (and pushed out).

=46rom 00ae42358249e879698029201e3cbb9ea155305e Mon Sep 17 00:00:00 200=
1
=46rom: Balaji T K <balajitk@ti.com>
Date: Fri, 24 Feb 2012 21:14:31 +0530
Subject: [PATCH] mmc: omap: Enable Auto CMD12

Enable Auto-CMD12 for multi block read/write on HSMMC
Tested on OMAP4430, OMAP3430 and OMAP2430 SDP

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index f29e1a2..729ac72 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -85,6 +85,7 @@
 #define BRR_ENABLE		(1 << 5)
 #define DTO_ENABLE		(1 << 20)
 #define INIT_STREAM		(1 << 1)
+#define ACEN_ACMD12		(1 << 2)
 #define DP_SELECT		(1 << 21)
 #define DDIR			(1 << 4)
 #define DMA_EN			0x1
@@ -115,6 +116,7 @@
 #define OMAP_MMC_MAX_CLOCK	52000000
 #define DRIVER_NAME		"omap_hsmmc"

+#define AUTO_CMD12		(1 << 0)	/* Auto CMD12 support */
 /*
  * One controller can have multiple slots, like on some omap boards us=
ing
  * omap.c controller driver. Luckily this is not currently done on any=
 known
@@ -175,6 +177,7 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	unsigned int		flags;
 	struct omap_hsmmc_next	next_data;

 	struct	omap_mmc_platform_data	*pdata;
@@ -766,6 +769,8 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
*host, struct mmc_command *cmd,
 		cmdtype =3D 0x3;

 	cmdreg =3D (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
+	if ((host->flags & AUTO_CMD12) && mmc_op_multi(cmd->opcode))
+		cmdreg |=3D ACEN_ACMD12;

 	if (data) {
 		cmdreg |=3D DP_SELECT | MSBS | BCE;
@@ -837,11 +842,14 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host
*host, struct mmc_data *data)
 	else
 		data->bytes_xfered =3D 0;

-	if (!data->stop) {
+	if (data->stop && ((!(host->flags & AUTO_CMD12)) || data->error)) {
+		omap_hsmmc_start_command(host, data->stop, NULL);
+	} else {
+		if (data->stop)
+			data->stop->resp[0] =3D OMAP_HSMMC_READ(host->base,
+							RSP76);
 		omap_hsmmc_request_done(host, data->mrq);
-		return;
 	}
-	omap_hsmmc_start_command(host, data->stop, NULL);
 }

 /*
@@ -1826,6 +1834,7 @@ static int __init omap_hsmmc_probe(struct
platform_device *pdev)
 	host->mapbase	=3D res->start;
 	host->base	=3D ioremap(host->mapbase, SZ_4K);
 	host->power_mode =3D MMC_POWER_OFF;
+	host->flags	=3D AUTO_CMD12;
 	host->next_data.cookie =3D 1;

 	platform_set_drvdata(pdev, host);
--=20
1.7.10.rc0.41.gfa678
