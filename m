Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB4EC4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 07:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiLBHts (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 02:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiLBHtr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 02:49:47 -0500
X-Greylist: delayed 1354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 23:49:42 PST
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C8213D3F
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 23:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=YqdG/sVsGpppFB4ly1ZzHyV7+aBNve0eyHvHaraNo80=; b=u8F5LPhQcpnA3XqBB7qTRNOPqS
        3K8ANgPfU5E2Yc+mR6bWHw9KVsfpANEswq9r0iBhnpO36CApSdqbclSnmHrHKv7rM0X+o86FiXiXW
        bkPv1yomDSw+w2tI42xj8SZZ4L8KbiSDuwroOAOOWKPSoqNabOUtiqhB//Q5NWnFVwEyAA/3SZcI5
        eKSTMyyfRHuBjqhwIZmcvfxsJnrnig1IWNTuuGXwjrjcXG4WQbuu1JYUFb9V14l5UJfRorhu43OSv
        WzIzfrfH1yRky9G+lGsdeDtG8ykOtqD99BA8lGdGThA3yaBpo2/W35kfDpTSSixJZfayzjrJKbUDp
        /XL7fYqw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1p10Rs-00082a-NW; Fri, 02 Dec 2022 08:27:04 +0100
Received: from [2a06:4004:10df:1:1df0:c65d:f90f:1c53]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1p10Rs-0008a6-De; Fri, 02 Dec 2022 08:27:04 +0100
Message-ID: <ff88a991-02da-f292-5958-c584344752c9@geanix.com>
Date:   Fri, 2 Dec 2022 08:27:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Content-Language: en-US
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
From:   Sean Nyekjaer <sean@geanix.com>
Subject: stm32mp157c eMMC DDR50 mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.7/26737/Thu Dec  1 09:22:33 2022)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

We are testing using the Octavo RED board with OSD32MP157c SoC 
(stm32mp157c).

We are using vanilla u-boot 2022.10(in basic mode without TF-A) and 
Linux kernel version 6.0.x.
I have ported the devicetree's from Octavo combined with upstream 
stm32mp1 boards.
But we are facing issues with running the eMMC in DDR50 mode, works fine 
in normal 50Mhz mode (without the mmc-ddr-3_3v in dts).

It works fine though, with the ST u-boot and ST Linux kernel.

One further note is it seems to work fine, when mounting a squashfs (aka 
readonly) in DDR50.

But ext4 fails with:
root@osd32mp1-red:~# mount /dev/mmcblk0p7 /media/
I/O error, dev mmcblk0, sector 1060144 op 0x1:(WRITE) flags 0x800 
phys_seg 1 prio class 2
Buffer I/O error on dev mmcblk0p7, logical block 422, lost async page write
I/O error, dev mmcblk0, sector 1060016 op 0x1:(WRITE) flags 0x800 
phys_seg 1 prio class 2
Buffer I/O error on dev mmcblk0p7, logical block 406, lost async page write
I/O error, dev mmcblk0, sector 1056768 op 0x1:(WRITE) flags 0x800 
phys_seg 2 prio class 2
Buffer I/O error on dev mmcblk0p7, logical block 0, lost async page write
Buffer I/O error on dev mmcblk0p7, logical block 1, lost async page write

/Sean
