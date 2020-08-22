Return-Path: <SRS0=q0fh=CA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A013C433DF
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Aug 2020 09:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4501B20738
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Aug 2020 09:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598089301;
	bh=utJ4hiZTOEP47TRMs3nrbGiyawUJF8FD0oQwzZTnQTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyP1LaP2jCLVqgb1G6w4ncu+cw2+gPIXXHXU5Q6dp0qMOlS61aH50JT+uv9Pvl+D1
	 VqGwDwAL/UHKi8i86HIcbm7+QjknN6b6ne4NxlCDVOzu04G2hh5dS1f7omqweDFCn1
	 blX+C0P7219sha2XfZQ7ujcJaggdc6SduotDBnnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgHVJlk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHVJlj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 22 Aug 2020 05:41:39 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C240620738;
        Sat, 22 Aug 2020 09:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598089298;
        bh=utJ4hiZTOEP47TRMs3nrbGiyawUJF8FD0oQwzZTnQTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjkUGhvDuiIgKve74tsGaykUZQ1NY3Yp8JyPjNKfY6G9HhmEBnTKGMPRtKbOkrqL2
         ceDb4MGlgQ2TNT/q6TqbYn/43/sgvevFiQHB8zFvbprQVRBeO4ABUaYvnkQFiGI8In
         RMGiI4IDmbH0L+0fE5RQUrniUQbzvafpCDEn1lV4=
Received: by pali.im (Postfix)
        id EF747860; Sat, 22 Aug 2020 11:41:36 +0200 (CEST)
Date:   Sat, 22 Aug 2020 11:41:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] mmc: sdio: Export CISTPL_VERS_1 attributes to
 userspace
Message-ID: <20200822094136.nm2hlq57jx2yfbju@pali>
References: <20200727133837.19086-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727133837.19086-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Ulf! I would like to remind you this SDIO patch series. Could you
please look and review it?

On Monday 27 July 2020 15:38:33 Pali Rohár wrote:
> CISTPL_VERS_1 structure contains useful information for identification
> of SDIO cards. It contains revision number according to which standard
> is SDIO card compliant. And also it contain human readable info strings
> which should contain manufacturer name or product information, like for
> old PCMCIA cards. SDIO simplified specification 3.00 just contain
> reference to PCMCIA metaformat specification for definition of that
> CISTPL_VERS_1 structure itself.
> 
> Human readable SDIO card strings can be useful for userspace to do card
> identification. Until now kernel exported to userspace only vendor and
> device numbers but these numbers do not help to identify new or unknown
> cards.
> 
> 
> I have tested these patches with Marwell 88W8997 SDIO card (WiFi+Bluetooth)
> and here is content of attributes available in userspace:
> 
> $ grep . /sys/class/mmc_host/mmc0/mmc0:0001/* /sys/class/mmc_host/mmc0/mmc0:0001/*/*
> /sys/class/mmc_host/mmc0/mmc0:0001/device:0x9140
> /sys/class/mmc_host/mmc0/mmc0:0001/info1:Marvell
> /sys/class/mmc_host/mmc0/mmc0:0001/info2:Wireless Device ID: 50
> /sys/class/mmc_host/mmc0/mmc0:0001/ocr:0x00200000
> /sys/class/mmc_host/mmc0/mmc0:0001/rca:0x0001
> /sys/class/mmc_host/mmc0/mmc0:0001/revision:1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/type:SDIO
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:MMC_TYPE=SDIO
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_ID=02DF:9140
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_REVISION=1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO1=Marvell
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO2=Wireless Device ID: 50
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO3=
> /sys/class/mmc_host/mmc0/mmc0:0001/vendor:0x02df
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/class:0x00
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/device:0x9141
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/info1:Marvell WiFi Device
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/modalias:sdio:c00v02DFd9141
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/revision:1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:DRIVER=mwifiex_sdio
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_CLASS=00
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_ID=02DF:9141
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_REVISION=1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_INFO1=Marvell WiFi Device
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_INFO2=
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:MODALIAS=sdio:c00v02DFd9141
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/vendor:0x02df
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/class:0x00
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/device:0x9142
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/info1:Marvell Bluetooth Device
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/modalias:sdio:c00v02DFd9142
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/revision:1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:DRIVER=btmrvl_sdio
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_CLASS=00
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_ID=02DF:9142
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_REVISION=1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_INFO1=Marvell Bluetooth Device
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_INFO2=
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:MODALIAS=sdio:c00v02DFd9142
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/vendor:0x02df
> /sys/class/mmc_host/mmc0/mmc0:0001/power/control:auto
> /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_active_time:0
> /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_status:unsupported
> /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_suspended_time:0
> /sys/class/mmc_host/mmc0/mmc0:0001/subsystem/drivers_autoprobe:1
> 
> As can be seen SDIO card does not provide all 4 info strings as required by
> SDIO/PCMCIA specificaion and the third and the second strings are empty.
> 
> 
> Pali Rohár (4):
>   mmc: sdio: Check for CISTPL_VERS_1 buffer size
>   mmc: sdio: Parse CISTPL_VERS_1 major and minor revision numbers
>   mmc: sdio: Extend sdio_config_attr macro and use it also for modalias
>   mmc: sdio: Export SDIO revision and info strings to userspace
> 
>  drivers/mmc/core/bus.c        | 12 ++++++++
>  drivers/mmc/core/sd.c         | 36 +++++++++++++++++++++--
>  drivers/mmc/core/sdio.c       | 24 ++++++++++++++++
>  drivers/mmc/core/sdio_bus.c   | 54 ++++++++++++++++++++++++++---------
>  drivers/mmc/core/sdio_cis.c   | 11 +++++++
>  include/linux/mmc/card.h      |  2 ++
>  include/linux/mmc/sdio_func.h |  2 ++
>  7 files changed, 124 insertions(+), 17 deletions(-)
> 
> -- 
> 2.20.1
> 
