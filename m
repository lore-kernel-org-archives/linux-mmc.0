Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86309C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1A4206BE
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXhkHZve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHXJw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgHXJvG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 05:51:06 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BE5C061574
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:06 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id h19so917624ual.10
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tccYStUAzNN9eUGFDB1AQI9/YFL7Lr7RuSk06lRq6+0=;
        b=bXhkHZveg7bx8tRi6wLxOSgnuGLOQ8fggTmPwouPEgjdIJL29T64Qtf9S/JI+jm359
         3VOiSuH27VftcN6ybQhNoExgy79gN6bDHzAQoGQk15B63JFIeJa+n7jJrT/9On5p49yN
         d2YSd7mDDdW/myUvGkKHqGGXCAOdQwuSBz7kk1IXHstWizNUuYoF1VJPyI50AM4K/Dsa
         Sjc/+90fFZnxyu1PagCec5qQgmIeFYVQ9PGo9U5KjNHm05LrAY0AjlCncJZZzVFCl7Ol
         2kYBOLNhpgTNQb9k1Oc5FDlF7CEG3Im/sS+JQQsd+pk7PyizSqHSGm0cB/u7bpr0OFNe
         r2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tccYStUAzNN9eUGFDB1AQI9/YFL7Lr7RuSk06lRq6+0=;
        b=LqqXoQBusder8eGzLsUxyO8HUBxsNXcLWl1/5OxV1g65Ju6IWy0Abd0HJyHeppPkmd
         7FuMHV6ec4cZ2aNtLA0dpAsFr26sgqwX4CzsEbQgJNumaUvbNVO/fCRIgOzt4tgN+DaL
         Ngqs0+5GdTzGik4tIECwZYHec464pUwhaY66sJXY4RfTH9Qi+prXq44c/oBw5ZkeVIO8
         j6KVdMSw2YF2wBbM+uaIRm/mxEcxy6J9v0K6EGyqv06Ut2noBAbESxo8LklI2VEg9HUs
         Lq6slJyxFG4rFhpw7GOTX7UXxDM33n3kypY9Obo1qlUNymhBcZeIqcvmONgYlAzH56Me
         n/cA==
X-Gm-Message-State: AOAM531c1mxYajJueicJeau860R2/nRfiB5oEpo+6/IBBX8gglml4itb
        pQ93MlqXXM9ff3HioTE0JnXI+kmQqaZ+/jQ5HSND/A==
X-Google-Smtp-Source: ABdhPJzZ2gRVnAvAA+A7kFyKCEbbhBymrSs2hb2NmmIQTm3kVUYZWGR4wuVkwcTMEI3wdYrBucXWxw2oEH1sYLGBQ0s=
X-Received: by 2002:ab0:3a85:: with SMTP id r5mr2012186uaw.100.1598262665146;
 Mon, 24 Aug 2020 02:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200727133837.19086-1-pali@kernel.org>
In-Reply-To: <20200727133837.19086-1-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:50:28 +0200
Message-ID: <CAPDyKFpYujZekinU6-HKagyH3h06=_wgugoLRBbUPP_6JgsMvQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: sdio: Export CISTPL_VERS_1 attributes to userspace
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Jul 2020 at 15:38, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
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
> I have tested these patches with Marwell 88W8997 SDIO card (WiFi+Bluetoot=
h)
> and here is content of attributes available in userspace:
>
> $ grep . /sys/class/mmc_host/mmc0/mmc0:0001/* /sys/class/mmc_host/mmc0/mm=
c0:0001/*/*
> /sys/class/mmc_host/mmc0/mmc0:0001/device:0x9140
> /sys/class/mmc_host/mmc0/mmc0:0001/info1:Marvell
> /sys/class/mmc_host/mmc0/mmc0:0001/info2:Wireless Device ID: 50
> /sys/class/mmc_host/mmc0/mmc0:0001/ocr:0x00200000
> /sys/class/mmc_host/mmc0/mmc0:0001/rca:0x0001
> /sys/class/mmc_host/mmc0/mmc0:0001/revision:1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/type:SDIO
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:MMC_TYPE=3DSDIO
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_ID=3D02DF:9140
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_REVISION=3D1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO1=3DMarvell
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO2=3DWireless Device ID=
: 50
> /sys/class/mmc_host/mmc0/mmc0:0001/uevent:SDIO_INFO3=3D
> /sys/class/mmc_host/mmc0/mmc0:0001/vendor:0x02df
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/class:0x00
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/device:0x9141
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/info1:Marvell WiFi Device
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/modalias:sdio:c00v02DFd914=
1
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/revision:1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:DRIVER=3Dmwifiex_sd=
io
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_CLASS=3D00
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_ID=3D02DF:9141
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_REVISION=3D1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_INFO1=3DMarvel=
l WiFi Device
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:SDIO_INFO2=3D
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/uevent:MODALIAS=3Dsdio:c00=
v02DFd9141
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/vendor:0x02df
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/class:0x00
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/device:0x9142
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/info1:Marvell Bluetooth De=
vice
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/modalias:sdio:c00v02DFd914=
2
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/revision:1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:DRIVER=3Dbtmrvl_sdi=
o
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_CLASS=3D00
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_ID=3D02DF:9142
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_REVISION=3D1.0
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_INFO1=3DMarvel=
l Bluetooth Device
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:SDIO_INFO2=3D
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/uevent:MODALIAS=3Dsdio:c00=
v02DFd9142
> /sys/class/mmc_host/mmc0/mmc0:0001/mmc0:0001:2/vendor:0x02df
> /sys/class/mmc_host/mmc0/mmc0:0001/power/control:auto
> /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_active_time:0
> /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_status:unsupported
> /sys/class/mmc_host/mmc0/mmc0:0001/power/runtime_suspended_time:0
> /sys/class/mmc_host/mmc0/mmc0:0001/subsystem/drivers_autoprobe:1
>
> As can be seen SDIO card does not provide all 4 info strings as required =
by
> SDIO/PCMCIA specificaion and the third and the second strings are empty.
>
>
> Pali Roh=C3=A1r (4):
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

Applied for next, thanks!

Kind regards
Uffe
