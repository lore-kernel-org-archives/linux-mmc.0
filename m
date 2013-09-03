From: Chris Ball <cjb@laptop.org>
Subject: Re: MMC_SWITCH command doesn't update the ext_csd data structure
Date: Tue, 03 Sep 2013 12:26:36 +0100
Message-ID: <86mwnub0yb.fsf@void.printf.net>
References: <5225C24B.9020705@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51817 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759831Ab3ICL0h (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Sep 2013 07:26:37 -0400
In-Reply-To: <5225C24B.9020705@de.bosch.com> (Dirk Behme's message of "Tue, 3
	Sep 2013 13:04:43 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Tue, Sep 03 2013, Dirk Behme wrote:
> +       if ((cmd.opcode == MMC_SWITCH) && ((cmd.arg >> 24) & 0x3)) {
> +               /* In case the IOCTL has modified the EXT_CSD, update
> it, i.e. re-read the EXT_CSD */
> +		mmc_update_ext_csd(card->ext_csd);
> +       }
> +

Your analysis looks good, please go ahead and submit a full patch.
Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
