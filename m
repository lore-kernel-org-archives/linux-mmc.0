Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8899BC4321E
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 16:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiLBQhl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiLBQhj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 11:37:39 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D7EBDCE0
        for <linux-mmc@vger.kernel.org>; Fri,  2 Dec 2022 08:37:31 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2E4n4n028115;
        Fri, 2 Dec 2022 17:37:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=gvm29KcgRx6Y6DpO4Z9kCMQrYj9ZmsGke8wJ4E+7ARQ=;
 b=iocEfI6nEQ2D5aMQmrQqw8x/mYxIVN1UqDLInA3vjRU9Gc1U5AOg3zEhvWlmudCNjsjV
 /jf8hamPehmdhokOHppvgZ0AuQimF2+7wHew6Jv26en0/hpTvrzVf5G/zo0OkBs4GiNm
 4VVktdrkByjV1L6QNK8qVoczEpaFk2Djh9AazwHpN7xlStWiKY1VuuDo6xJGO+sDSvRN
 XvSLRoVJv6FkVLYFrhqYb0dOd3/fXQHZlDOPuK+B0KJTHhndEq90AchRBdVpPnllNh04
 GCIKQPKrw/uC9AynIepy4hssVkqoMCEqyXe/FPc0RRafHtgRsG1P4QMowGSjsR70SOCd PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m6k713cn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 17:37:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 579D3100038;
        Fri,  2 Dec 2022 17:37:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3BCBA2309D9;
        Fri,  2 Dec 2022 17:37:05 +0100 (CET)
Received: from [10.201.20.201] (10.201.20.201) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 2 Dec
 2022 17:37:04 +0100
Message-ID: <daf69d14-6d99-703a-8a32-51729855b2c2@foss.st.com>
Date:   Fri, 2 Dec 2022 17:37:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: stm32mp157c eMMC DDR50 mode
To:     Sean Nyekjaer <sean@geanix.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Neeraj Dantu <dantuguf14105@gmail.com>
References: <ff88a991-02da-f292-5958-c584344752c9@geanix.com>
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <ff88a991-02da-f292-5958-c584344752c9@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.201]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_09,2022-12-01_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/2/22 08:27, Sean Nyekjaer wrote:
> Hi,
> 
> We are testing using the Octavo RED board with OSD32MP157c SoC 
> (stm32mp157c).
> 
> We are using vanilla u-boot 2022.10(in basic mode without TF-A) and 
> Linux kernel version 6.0.x.
> I have ported the devicetree's from Octavo combined with upstream 
> stm32mp1 boards.
> But we are facing issues with running the eMMC in DDR50 mode, works fine 
> in normal 50Mhz mode (without the mmc-ddr-3_3v in dts).
> 
> It works fine though, with the ST u-boot and ST Linux kernel.
> 
> One further note is it seems to work fine, when mounting a squashfs (aka 
> readonly) in DDR50.
> 
> But ext4 fails with:
> root@osd32mp1-red:~# mount /dev/mmcblk0p7 /media/
> I/O error, dev mmcblk0, sector 1060144 op 0x1:(WRITE) flags 0x800 
> phys_seg 1 prio class 2
> Buffer I/O error on dev mmcblk0p7, logical block 422, lost async page write
> I/O error, dev mmcblk0, sector 1060016 op 0x1:(WRITE) flags 0x800 
> phys_seg 1 prio class 2
> Buffer I/O error on dev mmcblk0p7, logical block 406, lost async page write
> I/O error, dev mmcblk0, sector 1056768 op 0x1:(WRITE) flags 0x800 
> phys_seg 2 prio class 2
> Buffer I/O error on dev mmcblk0p7, logical block 0, lost async page write
> Buffer I/O error on dev mmcblk0p7, logical block 1, lost async page write
> 
> /Sean

Hi Sean,

I've seen from the Octavo website, that the DT was available here:
https://github.com/octavosystems/OSD32MP1-RED-Device-tree

I've added Neeraj Dantu who made this DT, maybe he has more info.
 From github, it seems the DT was made for kernel 5.10.
And it has the mmc-ddr-3_3v property.
Was DDR52 mode properly working on the eMMC with this kernel version?

If yes, then could you bisect the issue and try to find the patch that 
caused the regression?

Maybe you could also enable dynamic traces on mmc.
That could help tracking the issue.


Best regards,
Yann


