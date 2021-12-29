Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97313C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Dec 2021 08:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhL2ItI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Dec 2021 03:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbhL2ItI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Dec 2021 03:49:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33420C061574
        for <linux-mmc@vger.kernel.org>; Wed, 29 Dec 2021 00:49:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so43097139wrw.10
        for <linux-mmc@vger.kernel.org>; Wed, 29 Dec 2021 00:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LtMfV/X3eLTt9OjBc8oZ4kCjdY8udNJJ595B9g45EX0=;
        b=SqOKWtEN2x45FFSen6vDbEdrsB+DMOTDvcuz/KOhR84s+aI2BGpbQXjRtZUsTMZim5
         xo8FOggVPw57DGtETzV1BgyeGBDM5o72jQ4g7lKZmv+Xhn5/yymlEKPJmdcXx+tETS7I
         17LTOepNDsftsnTW+WlPG9TjAcM0HAkG1DWWfdp60+2tqmts/tBmr+5pxSqYS2H1bTM8
         o4JNZXv4onypIo1BSHf3gt23kgAQaaAFChu1MvPp0wKLgGzs6meEAvC+QqIKnnJdtm50
         3u4JhgccVw8i2RBojNDGNo5zkjgPe1CgNQSgIWRDN0FfjUdfdd9AMJNn3ZuYIoQxYYUc
         5drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LtMfV/X3eLTt9OjBc8oZ4kCjdY8udNJJ595B9g45EX0=;
        b=gjXU5UzUwAv66PGyfVNtMnHdfrTSG3IzdFLBkTfM6OKj7jjvv5pljkmEeuSlC0njvs
         YVN8VRsVzke6vgxxqn2wyElSSEx08+1DAdSqt8HR0aIC2YUvztQpOavkR7j19WT+CnJM
         LcBA9AeTtxr/4kzmFi/8KCCx+w64/mWaGORwxxM9roAm1t6onzoUwqofuWxeJMQkkhn1
         yYhRD6fNbVvFvxzAZ5S9jMaQlyrck2HMdJ1GM4pX3bY1udOWZdHeZGqkx0kaQRuTtMpH
         grMjAnV3UzvRV+3rNujQyzNz7tmrATFgBjp503yHOhSdPYCo58eubr7pSx21QnJ/LbO8
         0qiA==
X-Gm-Message-State: AOAM532jZ7O1zZrbdEbmNCmijScDgVJbaDvJPas1xrs1A3b6SUg7hfig
        5Ve1QsPhckoIz+SJdm2Tl2U=
X-Google-Smtp-Source: ABdhPJwctyFzKLLTGG4qWcXGX7NLBoBR46+88l7kb/aUJTB18uIryU8r8/nqR5Ze3AiOw3mr4iDmnw==
X-Received: by 2002:a5d:590e:: with SMTP id v14mr19752124wrd.208.1640767744625;
        Wed, 29 Dec 2021 00:49:04 -0800 (PST)
Received: from ?IPV6:2a02:908:1980:7720::dea7? ([2a02:908:1980:7720::dea7])
        by smtp.gmail.com with ESMTPSA id f18sm19767841wre.7.2021.12.29.00.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 00:49:04 -0800 (PST)
Message-ID: <a91b73ab-5f2f-f748-95aa-63fa2d7b576b@gmail.com>
Date:   Wed, 29 Dec 2021 09:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: nothing happens upon SD card insertion (Asus Zenbook UM425IA,
 RTS522A)
Content-Language: en-US
To:     Ricky WU <ricky_wu@realtek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <sq6sp6$cs9$1@ciao.gmane.io>
 <CAPDyKFon=yS81Nxyx30s4sgtMT8VdurRNOCSzM3pzZTWTBThyw@mail.gmail.com>
 <1355e2bb760448268571554441a51748@realtek.com>
From:   Julian Sikorski <belegdol@gmail.com>
In-Reply-To: <1355e2bb760448268571554441a51748@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ricky,

thank you for looking into this. I have investigated a bit further and 
it appears that I can somewhat reliably trigger the sdcard detection 
during first insert after resume by calling lspci. As in:
- insert card
- wait 20 seconds, nothing happens
- issue lspci
- sdcard is detected
If I eject and reinsert the card, however, lscpi will no longer help 
unless I suspend the machine, reboot would probably work as well.

I enabled dynamic debugging and got the following output. You can see 
that there is a gap between 09:35:25 and 09:36:42 during which I 
inserted the card into the laptop.

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: : Realtek PCI-E 
Card Reader found at 0000:02:00.0 [10ec:522a] (rev 1)

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: 
rtsx_pci_acquire_irq: pcr->msi_en = 1, pci->irq = 63

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: PID: 0x522a, IC 
version: 0x02

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: Cfg 0x724: 
0xeeffffff

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: Cfg 0x814: 
0x80000062

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: pcr->aspm_en = 0x2

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: 
pcr->sd30_drive_sel_1v8 = 0x3

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: 
pcr->sd30_drive_sel_3v3 = 0x3

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: 
pcr->card_drive_sel = 0x41

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: pcr->flags = 0x0

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: RTSX_BIER: 
0x36400000

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 0)

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: n = 118, div = 3

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: ssc_depth = 1

Dez 29 09:35:25 snowball3 kernel: rtsx_pci 0000:02:00.0: --> 
rtsx_pci_idle_work

Dez 29 09:36:42 snowball3 kernel: rtsx_pci 0000:02:00.0: --> 
rtsx_pci_card_detect

Dez 29 09:36:42 snowball3 kernel: rtsx_pci 0000:02:00.0: irq_status: 
0x00010000

Dez 29 09:36:42 snowball3 kernel: rtsx_pci 0000:02:00.0: card_inserted: 
0x10000, card_removed: 0x0

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: mmc0: cannot verify signal voltage switch

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 30MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 30MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 30)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: n = 98, div = 1

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: ssc_depth = 2

Dez 29 09:36:43 snowball3 kernel: mmc0: new ultra high speed SDR50 SDHC 
card at address aaaa

Dez 29 09:36:43 snowball3 kernel: mmcblk0: mmc0:aaaa SL32G 29.7 GiB

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedff000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel:  mmcblk0: p1

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedff000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb2b000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb27000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92f000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb28000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb29000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb2c000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf5000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93f000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93e000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93d000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93c000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93b000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93a000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce939000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce938000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce937000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce936000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce935000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce934000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce933000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce932000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92e000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92d000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92c000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92d000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92e000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce932000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce933000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce934000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce930000, Len: 0x2000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcec18000, Len: 0x6000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedc0000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf720000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf730000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8c0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8d0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8e0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8f0000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce934000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce933000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce932000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92e000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92d000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92c000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce935000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce936000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce937000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce938000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce939000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93a000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93b000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93c000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93d000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcec18000, Len: 0x8000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93e000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93f000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf5000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb2c000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce930000, Len: 0x2000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf338000, Len: 0x6000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedc0000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf720000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf730000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8c0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8d0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8e0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8f0000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce880000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce890000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8a0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8b0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf1a0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf1b0000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcffd0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcea60000, Len: 0xd000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb2c000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb1b000, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb1a200, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb19400, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf3000, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedfa200, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcec68400, Len: 0x7c00

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcff2c000, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf5000, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93f200, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf338400, Len: 0x7c00

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93f000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb2c000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb2d400, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb2e600, Len: 0x200

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb2f800, Len: 0x800

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfebf000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcffee000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfff0000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb1d000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb26000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb25000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb24000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede5000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfff4000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb23000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf9000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede9000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf1000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb07000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf0000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf5000, Len: 0x1000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce930000, Len: 0x2000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf338000, Len: 0x6000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedc0000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf720000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf730000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8c0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8d0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8e0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8f0000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce880000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce890000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8a0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8b0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf1a0000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf1b0000, Len: 0xf000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcea60000, Len: 0x10000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcffd0000, Len: 0xd000

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:36:43 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf5000, Len: 0x1000

Dez 29 09:36:44 snowball3 kernel: rtsx_pci 0000:02:00.0: --> 
rtsx_pci_idle_work

The following gets printed if I click eject button in Nautilus. Please 
note that the card does not disappear as it should and subsequent clicks 
result in "No object for D-Bus interface" message.

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb20000, Len: 0x200

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf5000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb20000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93f000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf0000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb07000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf1000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb1e000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcff7f000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfff6000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb1f000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede9000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf9000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb23000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfff4000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede5000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf338000, Len: 0x8000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb24000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb25000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb26000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede2000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcffe8000, Len: 0x2000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfecd0000, Len: 0x6000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcea40000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf2e0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf2f0000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8c0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8d0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8e0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8f0000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce880000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce890000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8a0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8b0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcec40000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcec50000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcff60000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfeca0000, Len: 0xd000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedfa000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb26000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel:  mmcblk0: p1

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcff2c000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcffff000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfecca000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfefc000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfefd000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfefe000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfeff000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf3000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfeb8000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede3000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfed98000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93c000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedfa000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93b000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce93a000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce939000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede4000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce938000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce937000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf4000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce936000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce935000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf2000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92c000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfff9000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92d000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce92e000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb1c000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce932000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce933000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb16000, Len: 0x2000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcea38000, Len: 0x6000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcea20000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf3c0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf3d0000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8c0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8d0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8e0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8f0000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb21000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce933000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedf6000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedee000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfedef000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfefb000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfeccb000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb22000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce934000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb26000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfefe000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfefd000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcfefc000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfecca000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcffff000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf338000, Len: 0x8000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcff2c000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb25000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xceb24000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede5000, Len: 0x1000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcffe8000, Len: 0x2000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcec18000, Len: 0x6000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcffd0000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf1a0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf1b0000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8c0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8d0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8e0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8f0000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce880000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce890000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8a0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xce8b0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf3c0000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcf3d0000, Len: 0xf000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xcea20000, Len: 0x10000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfed60000, Len: 0xd000

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Switch card 
clock to 100MHz

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: Internal SSC 
clock: 100MHz (cur_clock = 100)

Dez 29 09:42:48 snowball3 kernel: rtsx_pci 0000:02:00.0: DMA addr: 
0xfede5000, Len: 0x1000

Dez 29 09:42:49 snowball3 kernel: rtsx_pci 0000:02:00.0: --> 
rtsx_pci_idle_work

Let me know if I should enable more debugging, and if so, where.

Best regards,
Julian

Am 29.12.21 um 04:36 schrieb Ricky WU:
> Hi Julian，
> 
> We can't reproduce this issue on our side
> Can you check your socket is well and print more driver debug message?
> 
> BR,
> Ricky
>> -----Original Message-----
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Sent: Wednesday, December 29, 2021 1:07 AM
>> To: Julian Sikorski <belegdol@gmail.com>; Ricky WU <ricky_wu@realtek.com>;
>> Rui Feng <rui_feng@realsil.com.cn>
>> Cc: linux-mmc@vger.kernel.org
>> Subject: Re: nothing happens upon SD card insertion (Asus Zenbook UM425IA,
>> RTS522A)
>>
>> + Ricky and Rui,
>>
>> On Sat, 25 Dec 2021 at 11:50, Julian Sikorski <belegdol@gmail.com> wrote:
>>>
>>> Hello,
>>>
>>> I have an Asus Zenbook UM425IA laptop with Realtek RTS522A card reader:
>>>
>>> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
>>> RTS522A PCI Express Card Reader (rev 01)
>>
>> Hi Julian,
>>
>> I assume that means you are using the
>> drivers/mmc/host/rtsx_pci_sdmmc.c. So, I have looped in some of the main
>> authors to this mmc/sd driver. Let's see if they can help in some way.
>>
>> Kind regards
>> Uffe
>>
>>>
>>>
>>> Almost every time when I insert a card into it, nothing happens - no
>>> dmesg message or anything.
>>>
>>> echo 1 | sudo tee -a /sys/kernel/debug/tracing/events/mmc/enable
>>>
>>> sudo cat /sys/kernel/debug/tracing/trace_pipe > mmc_trace.txt
>>>
>>> also results in an empty file. If I am lucky, the card will be
>>> detected after some delay and the following will appear in the log:
>>>
>>> Dez 25 11:34:41 snowball3 kernel: mmc0: cannot verify signal voltage
>>> switch
>>>
>>> Dez 25 11:34:41 snowball3 kernel: mmc0: new ultra high speed SDR50
>>> SDHC card at address aaaa
>>>
>>> Dez 25 11:34:41 snowball3 kernel: mmcblk0: mmc0:aaaa SL32G 29.7 GiB
>>>
>>> Dez 25 11:34:41 snowball3 kernel:  mmcblk0: p1
>>>
>>>
>>> How can I investigate this further? As things stand now, the reader is
>>> almost unusable. I am using 5.15.11-200.s0ix01.fc35.x86_64 kernel.
>>> Thank you in advance.
>>>
>>> Best regards,
>>> Julian
>>>
>> ------Please consider the environment before printing this e-mail.
