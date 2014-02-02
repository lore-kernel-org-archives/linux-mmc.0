From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v2] mmc-utils: add eMMC 5.0 FFU support
Date: Sun, 02 Feb 2014 17:52:13 +0000
Message-ID: <86wqhdxv02.fsf@void.printf.net>
References: <1390506264-17107-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52452 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbaBBRwP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 2 Feb 2014 12:52:15 -0500
In-Reply-To: <1390506264-17107-1-git-send-email-grundler@chromium.org> (Grant
	Grundler's message of "Thu, 23 Jan 2014 11:44:24 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

Hi Grant,

Still waiting on the remaining warning/error, and also noticed a
trivial typo:

On Thu, Jan 23 2014, Grant Grundler wrote:
> +	/* 2) Host send CMD6 to set MODE_CONFIG[30] = 0x01 */
> +	memset(&idata, 0, sizeof(idata));
> +	idata.opcode = MMC_SWITCH;
> +        idata.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +			(30 << 16) |	/* index */
> +			(1 << 8) |	/* value */
> +			EXT_CSD_CMD_SET_NORMAL;
> +	idata.flags = MMC_RSP_R1B | MMC_CMD_AC;;
> +	ret = ioctl(fd, MMC_IOC_CMD, &idata);
> +	if (ret) {
> +		retcode = ret;
> +		printf("ioctl: MMC_SWITCH (eMMC 5.0 FW Update) %m\n");
> +		goto abort_update;
> +	}
> +
> +	/* 2) send CMD25 0x0000FFFF */

I think that first 2) should be a 1).  Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
