From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mxcmmc: Internal error: Oops: 17 [#1] ARM from
	sg->offset
Date: Wed, 22 Jan 2014 10:11:38 +0000
Message-ID: <20140122101137.GX15937@n2100.arm.linux.org.uk>
References: <1390365159-29239-1-git-send-email-chris.ruehl@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:44674 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751773AbaAVKLy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 05:11:54 -0500
Content-Disposition: inline
In-Reply-To: <1390365159-29239-1-git-send-email-chris.ruehl@gtsys.com.hk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: s.hauer@pengutronix.de, mpa@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm@lists.infradead.org

On Wed, Jan 22, 2014 at 12:32:39PM +0800, Chris Ruehl wrote:
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index f7199c8..8645d6a 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -347,7 +347,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>  		return 0;
>  
>  	for_each_sg(data->sg, sg, data->sg_len, i) {
> -		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
> +		if (sg && (sg->offset & 3 || sg->length & 3 || sg->length < 512)) {

sg should never be NULL here - so this is probably papering over a bug.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
