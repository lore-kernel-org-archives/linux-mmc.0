From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH] SD/MMC: fix the issue of SDHC performance regression
Date: Sun, 13 Nov 2011 21:44:45 +0530
Message-ID: <000301cca21f$5fda9c30$1f8fd490$@org>
References: <1320658589-13143-1-git-send-email-b32616@freescale.com>	<m2ipmw133p.fsf@bob.laptop.org> <20111108094734.GA1592@ladygaga> <m2lirqybtm.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:31439 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab1KMQOx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Nov 2011 11:14:53 -0500
In-Reply-To: <m2lirqybtm.fsf@bob.laptop.org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Aaron Lu' <aaron.lu@amd.com>
Cc: 'Qiang Liu' <b32616@freescale.com>, linux-mmc@vger.kernel.org, leoli@freescale.com, kumar.gala@freescale.com

Chris, Aaron,

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
a230e7f..670fd7f 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -306,7 +306,7 @@ static int mmc_read_switch(struct mmc_card *card)
                goto out;
        }
 
-       if (status[13] & UHS_SDR50_BUS_SPEED)
+       if (status[13] & SD_MODE_UHS_SDR25)
                card->sw_caps.hs_max_dtr = 50000000;
 
Using SD_MODE_UHS_SDR25 macro name is not appropriate here. It's really not
the SDR25 mode (although clock rate is 50mhz), it's High speed mode only.
"Qiang Liu" patch had defined new marco "SD_MODE_HIGH_SPEED" which looks
most appropriate to use here.

@@ -99,6 +99,7 @@ struct sd_ssr {
 struct sd_switch_caps {
 	unsigned int		hs_max_dtr;
 	unsigned int		uhs_max_dtr;
+#define HIGH_SPEED_MAX_DTR	50000000
 #define UHS_SDR104_MAX_DTR	208000000
 #define UHS_SDR50_MAX_DTR	100000000
 #define UHS_DDR50_MAX_DTR	50000000
@@ -106,11 +107,13 @@ struct sd_switch_caps {
 #define UHS_SDR12_MAX_DTR	25000000
 	unsigned int		sd3_bus_mode;
 #define UHS_SDR12_BUS_SPEED	0
+#define HIGH_SPEED_BUS_SPEED	1
 #define UHS_SDR25_BUS_SPEED	1
 #define UHS_SDR50_BUS_SPEED	2
 #define UHS_SDR104_BUS_SPEED	3
 #define UHS_DDR50_BUS_SPEED	4

+#define SD_MODE_HIGH_SPEED	(1 << HIGH_SPEED_BUS_SPEED)
 #define SD_MODE_UHS_SDR12	(1 << UHS_SDR12_BUS_SPEED)
 #define SD_MODE_UHS_SDR25	(1 << UHS_SDR25_BUS_SPEED)
 #define SD_MODE_UHS_SDR50	(1 << UHS_SDR50_BUS_SPEED)
--

Regards,
Subhash


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Chris Ball
> Sent: Tuesday, November 08, 2011 7:08 PM
> To: Aaron Lu
> Cc: Qiang Liu; linux-mmc@vger.kernel.org; leoli@freescale.com;
> kumar.gala@freescale.com; subhashj@codeaurora.org
> Subject: Re: [PATCH] SD/MMC: fix the issue of SDHC performance
> regression
> 
> Hi,
> 
> On Tue, Nov 08 2011, Aaron Lu wrote:
> > SDR25 is also 50MHZ, the same frequency as high speed.
> > Or we can add a new macro for high speed like qiang has done,
> > which one you prefer?
> 
> The new macro makes most sense to me -- if no-one disagrees, I'll
> convert Liu's patch into a rename patch and queue it as a cleanup
> for 3.2.  Thanks!
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

