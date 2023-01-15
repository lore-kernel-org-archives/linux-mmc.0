Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66439C677F1
	for <linux-mmc@archiver.kernel.org>; Sun, 15 Jan 2023 00:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjAOAnZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 14 Jan 2023 19:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAOAnY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Jan 2023 19:43:24 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D049EF6
        for <linux-mmc@vger.kernel.org>; Sat, 14 Jan 2023 16:43:22 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s66so19924910oib.7
        for <linux-mmc@vger.kernel.org>; Sat, 14 Jan 2023 16:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VA+b6ERucM0SVhgS+CxkVoqDPdylXXEER7Oavou/n5c=;
        b=AWOVJoTRCZIzDDPEVrLicc1SKpwl7KTn8Ol48utvExDUblpnjljkkxvHgz5x7ZXre+
         8m1djuSOUoerjvNlDkOsvOoru5Slmn51JdtG4yWzqApm65GcAawUt0a4970Ve8qE/PbE
         WIpzUe/igEignY6RXJsMefYQMCJguWlv4sRLkistNu2yHDIEgQ5le/hWruMQxtCBR8qR
         R0Xe1ZeaqdcCUIm6QnssL2hDeKkpiOJ4cANGy/HkgZiIyg5h2uIoq1Znienu3k+LNYC0
         mG/pqdest+Z0kWbWIAyWD+qrcbh4pkalGKoAU1Y3Z3G0iffow+5qADIIMc/6gwB/2uWn
         mYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA+b6ERucM0SVhgS+CxkVoqDPdylXXEER7Oavou/n5c=;
        b=NVyRt0EXJWqRy+P8VBEcDVgMkmPRJhuuxOgiBhAE0Eh4I3mliLerzVy6e3A4JFMIkl
         ActuNYW/1PtBw7lNzcDX2j4ODPHnL9O6EH0/Uv1H7mp0Zx1CSKzMIRc1mBGkb/+to4SP
         rhYzb01S8t6jI7/x6hFFFZPvFpkDo6qaj7t5vAWjKPV9zQLh/BAVAoMaBvdLZT57aqyo
         c0ZNHMVUiWcUlYG3rA+TD6d8NYxSB8kQR0oClpuu6fUNFtditno4kJHmc29hSlOSVWnT
         5ViigNWRiBZFZp0O/+CJR8oPye/670ndZMhPS3azayYxiJw+xa1FuiCnUwr0oqn5HbuC
         esug==
X-Gm-Message-State: AFqh2kqu+Sq4HsZ/Yu/O0v/r9AZbaRlHj8Nh/+uVtbv0noKB1WQTW+Tt
        d0Uom2p+VIfGINuPDAClCa7UaQ==
X-Google-Smtp-Source: AMrXdXtmlbzCnjvw02a750r61CcJJIRVFXhgi7CC+Te697GM+nVvImU+iajKPZiIXIE5Si7tn9Lk3Q==
X-Received: by 2002:aca:c189:0:b0:35a:6005:3dc5 with SMTP id r131-20020acac189000000b0035a60053dc5mr35396207oif.51.1673743401843;
        Sat, 14 Jan 2023 16:43:21 -0800 (PST)
Received: from [192.168.86.224] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id l10-20020a056808020a00b00360e46a1edasm10935583oie.22.2023.01.14.16.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 16:43:21 -0800 (PST)
Message-ID: <fe206345-9445-f1be-02c1-b3cc39a533ef@landley.net>
Date:   Sat, 14 Jan 2023 18:55:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/22] usb: remove the dead USB_OHCI_SH option
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sh@vger.kernel.org
References: <20230113062339.1909087-1-hch@lst.de>
 <20230113062339.1909087-3-hch@lst.de> <Y8EEbCP6PRMzWP5y@kroah.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <Y8EEbCP6PRMzWP5y@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 1/13/23 01:12, Greg Kroah-Hartman wrote:
> On Fri, Jan 13, 2023 at 07:23:19AM +0100, Christoph Hellwig wrote:
>> USB_OHCI_SH is a dummy option that never builds any code, remove it.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  drivers/usb/host/Kconfig | 11 -----------
>>  1 file changed, 11 deletions(-)
>> 
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 8d799d23c476e1..ca5f657c092cf4 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -548,17 +548,6 @@ config USB_OHCI_HCD_SSB
>>  
>>  	  If unsure, say N.
>>  
>> -config USB_OHCI_SH
>> -	bool "OHCI support for SuperH USB controller (DEPRECATED)"
>> -	depends on SUPERH || COMPILE_TEST
>> -	select USB_OHCI_HCD_PLATFORM
>> -	help
>> -	  This option is deprecated now and the driver was removed, use
>> -	  USB_OHCI_HCD_PLATFORM instead.
>> -
>> -	  Enables support for the on-chip OHCI controller on the SuperH.
>> -	  If you use the PCI OHCI controller, this option is not necessary.
>> -
>>  config USB_OHCI_EXYNOS
>>  	tristate "OHCI support for Samsung S5P/Exynos SoC Series"
>>  	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>> -- 
>> 2.39.0
>> 
> 
> Do you want all of these to go through a single tree, or can they go
> through the different driver subsystem trees?

Neither please. Multiple people are objecting.

Rob
