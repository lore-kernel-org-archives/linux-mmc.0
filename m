From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: Problem when using SDIO interrupts on Nexus One
Date: Mon, 11 Apr 2011 17:38:05 +0530
Message-ID: <001b01cbf841$1f354aa0$5d9fdfe0$@org>
References: <BANLkTin2cVt7236-Ds+3Wg0SsCuSSSZGsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001C_01CBF86F.38ED86A0"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30177 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1DKMIL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 08:08:11 -0400
In-Reply-To: <BANLkTin2cVt7236-Ds+3Wg0SsCuSSSZGsg@mail.gmail.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Johan' <kungjohan@gmail.com>, linux-mmc@vger.kernel.org
Cc: bryanh@codeaurora.org

This is a multi-part message in MIME format.

------=_NextPart_000_001C_01CBF86F.38ED86A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Johan,

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Johan
> Sent: Friday, April 08, 2011 12:53 AM
> To: linux-mmc@vger.kernel.org
> Subject: Problem when using SDIO interrupts on Nexus One
> 
> I have a Nexus One Android phone and I am trying to use a SDIO device
> connected to the memory slot available on the phone. This device uses
> SDIO interrupts on SD_D1 to signal interrupts to the host.
> 
> I am using a 2.6-32 kernel from the android-msm-2.6.32 branch
> available from git://android.git.kernel.org/kernel/msm.git and has
> built the kernel with the mahimahi_defconfig.
> 
> I have modified drivers/mmc/host/msm_sdcc.c so that SDIO interrupts is
> used -> msmsdcc_sdioirq = 1;
> 
> My device is working quite well with SDIO interrupts but sometime I
> can miss a interrupt and will get this interrupt when I try to send a
> command to my device. I can see this behaviour if my device tries to
> signal a interrupt 1 second of the last command sent to the device.
> The SDIO interrupt line goes low and the host does not signal the
> interrupt at once. My assumption is that this is due to some kind of
> power management of the SDIO controller. I will get this interrupt
> when I activate the SDIO controller by sending a command to my device.
>  I have verified this with a logic analyzer attached to the bus and
> can attach a screen shot if anyone wants to see this.
> 
> So my question is if anyone know how to get reliable SDIO interrupts
> on this host, Qualcomm MSM? It seems like Qualcomm does not provide
> documentation for this host.

I had a look at the msm_sdcc.c and it looks like all the SDCC interrupts are
masked when driver goes into
Suspend. So when you say interrupts are getting missed it might be the case
that system is in suspend state.

To fix this, you can keep the SDIO interrupts enabled while going into
suspend. I have made a patch (attached with this mail) with this change.
Please give a try and let me know if it works for you or not.

Regards,
Subhash

> 
> Best Regards
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_001C_01CBF86F.38ED86A0
Content-Type: application/octet-stream;
	name="0001-msm-msm_sdcc-handle-SDIO-interrupts-during-suspend.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-msm-msm_sdcc-handle-SDIO-interrupts-during-suspend.patch"

>From 3a4f474d78e7735ac3115edc307ed083dcfaeb53 Mon Sep 17 00:00:00 2001=0A=
From: Subhash Jadavani <subhashj@codeaurora.org>=0A=
Date: Mon, 11 Apr 2011 17:29:19 +0530=0A=
Subject: [PATCH] msm: msm_sdcc: handle SDIO interrupts during suspend=0A=
=0A=
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>=0A=
---=0A=
 drivers/mmc/host/msm_sdcc.c |   11 ++++++++---=0A=
 1 files changed, 8 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c=0A=
index fb56272..fa9332f 100644=0A=
--- a/drivers/mmc/host/msm_sdcc.c=0A=
+++ b/drivers/mmc/host/msm_sdcc.c=0A=
@@ -1330,10 +1330,15 @@ msmsdcc_suspend(struct platform_device *dev, =
pm_message_t state)=0A=
 =0A=
 		if (mmc->card && mmc->card->type !=3D MMC_TYPE_SDIO)=0A=
 			rc =3D mmc_suspend_host(mmc, state);=0A=
-		if (!rc)=0A=
+=0A=
+		if (mmc->card && mmc->card->type =3D=3D MMC_TYPE_SDIO) {=0A=
+			msmsdcc_writel(host, (MCI_SDIOINTOPERMASK |=0A=
+					MCI_SDIOINTMASK), MMCIMASK0);=0A=
+		} else if (!rc) {=0A=
 			msmsdcc_writel(host, 0, MMCIMASK0);=0A=
-		if (host->clks_on)=0A=
-			msmsdcc_disable_clocks(host, 0);=0A=
+			if (host->clks_on)=0A=
+				msmsdcc_disable_clocks(host, 0);=0A=
+		}=0A=
 	}=0A=
 	return rc;=0A=
 }=0A=
-- =0A=
1.7.1.1=0A=
=0A=

------=_NextPart_000_001C_01CBF86F.38ED86A0--

