From: jyothishree <jyothi281@gmail.com>
Subject: Re: Data CRC error in eMMC
Date: Mon, 30 Jul 2012 04:44:51 +0000 (UTC)
Message-ID: <loom.20120730T063848-667@post.gmane.org>
References: <loom.20120727T101420-949@post.gmane.org> <003901cd6d51$5097da00$f1c78e00$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43603 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab2G3EpE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Jul 2012 00:45:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1Svhqm-00009b-Qv
	for linux-mmc@vger.kernel.org; Mon, 30 Jul 2012 06:45:02 +0200
Received: from 203.247.149.152 ([203.247.149.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jul 2012 06:45:00 +0200
Received: from jyothi281 by 203.247.149.152 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jul 2012 06:45:00 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Asutosh Das <asutoshd <at> codeaurora.org> writes:

> 
> >> I am getting data CRC error for CMD25 during suspend mode.
> Try checking if the voltage supplied to card is correct after resuming.
> 
> Thanks
> Asutosh
> 
> --
> Sent by consultant of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> -----Original Message-----
> From: linux-mmc-owner <at> vger.kernel.org
> [mailto:linux-mmc-owner <at> vger.kernel.org] On Behalf Of jyothishree
> Sent: Friday, July 27, 2012 1:49 PM
> To: linux-mmc <at> vger.kernel.org
> Subject: Data CRC error in eMMC
> 
> Hello,
> I am getting data CRC error for CMD25 during suspend mode. 
> because of this eMMC error, partition is mapped as read only and system
> hangs.
> pease let me know how to approach to fix this issue.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
> body of a message to majordomo <at> vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
Hello Asutosh Das,

Thanks for your reply.
This problem is during suspend mode.
Voltage value set in board file is as shown below.SDCC1 --> eMMC

mmc_vdd_reg_data[MAX_SDCC_CONTROLLER]{
[SDCC1] = {
                .name = "sdc_vdd",
                .high_vol_level = 2950000,
                .low_vol_level = 2950000,
                .always_on = 1,
                .lpm_sup = 1,
                .lpm_uA = 18000, //9000-->18000 (18mA)
                .hpm_uA = 200000, /* 200mA */
        },
}

and vdd_io data values are
mmc_vdd_io_reg_data[MAX_SDCC_CONTROLLER] = {
 [SDCC1] = {
                .name = "sdc_vdd_io",
                .always_on = 1,
                .high_vol_level = 1800000,
                .low_vol_level = 1800000,
                .hpm_uA = 200000, /* 200mA */
        },
}

and as per above details, voltage supplied to the card is same high_vol and 
low_volt is same 2.95
Please let me know in mmc driver if there is any point where we can check the 
supplied voltage during suspend and resume.

Best regards,
Jyothishree NK



