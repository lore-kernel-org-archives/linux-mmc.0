Return-Path: <SRS0=Ubev=IG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06E8C433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 12:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9035364D92
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 12:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhCHMBv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 07:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhCHMBt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 07:01:49 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7302FC06174A
        for <linux-mmc@vger.kernel.org>; Mon,  8 Mar 2021 04:01:49 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id o11so9622877iob.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Mar 2021 04:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5LHVcOGdhAoJthrWSfup2O7q0CV7Yhvcd8FBK4vAcKs=;
        b=FJfzwNdLDfGyrDW35w0murMqESEHJ5paU/ZdJqrgMc1bBwZSySKloqfO9eFvJ23jOZ
         6Nngbw6J21a4OPUAKr4OSv3uAzAAKZjS+wt6f7ouGV4Z6DMf4NY+6Z30fpq0BfNtzdBS
         Ps/+2HHkzW0j/rMEVxUFP1de3SYGCpYes9aRjmorMM8bMzM0E27upsDFQx0g2cJ4D6vT
         r9137lbZkcFGxTSOcmSWG5fpC1lPwiRHZo78MFiBIvRE3u8rG75emghV3ivN55BlleVt
         7Eyc99tFBBaDnt5WmMUKHMxARDwvFNKGCPU7qgAab2eaCvWnTYtI+ADfph4+GDcg5eZP
         1S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=5LHVcOGdhAoJthrWSfup2O7q0CV7Yhvcd8FBK4vAcKs=;
        b=LTNKEdCrpuHKkMIhZR4qkjWt4yyLl2fHyK1hOobd0hLa/DYWBNJXhynAspalDwrxEj
         7xnntGs3bWJW2VlFyq9yH+QIPgK2NLS9Xn8MoTlDeRJhyCOwW+AfRwyc8RZ4ZfRZdPSH
         Ju6bvupuu5gghIR7akkjQiNNylMISG+roUTjZQombTThL2/lLWvE1TtqLQzkwbf0jqB6
         sNWtVnGpUGx+ikmdReRNqqRC31AN/wCHB8xbspaEns9ODRomc27/zIHhUkcy3TRjseUD
         yGgbAM1J0rKeDiahlClLLYrSxPWQE796KBh8jiX8rAt7V7T4jrE1EmWzBtYB/aRYttf5
         LNDQ==
X-Gm-Message-State: AOAM532X4fxmvZTrKOO07dhtRvVHSgELaeLMK2xa0WbrxnskPkAYmtt3
        QgthHNncaX4bbA7CebKrT1End+uEWnM=
X-Google-Smtp-Source: ABdhPJxm9Fx9CBvHtzjViqFeDrz9nE/+X9z6ffTT3Vh5cVxx43zWU8OZdfoYVvJst2P0dyhZgnYe9w==
X-Received: by 2002:a6b:7c4a:: with SMTP id b10mr15882020ioq.170.1615204908983;
        Mon, 08 Mar 2021 04:01:48 -0800 (PST)
Received: from [0.0.0.0] ([144.168.164.26])
        by smtp.gmail.com with ESMTPSA id s18sm6197977ilt.9.2021.03.08.04.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:01:48 -0800 (PST)
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "Shirley,Her" <shirley.her@bayhubtech.com>
From:   Andy Lavr <andy.lavr@gmail.com>
Subject: [BUG] mmc0: Internal clock never stabilised.
Message-ID: <4109a876-4521-8268-9bec-ba0c768d93ee@gmail.com>
Date:   Mon, 8 Mar 2021 12:01:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hey,


*Kernel linux-next 20210305
*


I haven't used mmc for a very long time and I can't say when the 
regression appeared.



The problem is with this function (drivers/mmc/host/sdhci-pci-o2micro.c):


static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
{
         ktime_t timeout;
         u16 scratch;
         u32 scratch32;

         /* PLL software reset */
         scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
         scratch32 |= O2_PLL_SOFT_RESET;
         sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
         udelay(1);
         scratch32 &= ~(O2_PLL_SOFT_RESET);
         sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);

         /* PLL force active */
         scratch32 |= O2_PLL_FORCE_ACTIVE;
         sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);

         /* Wait max 20 ms */
         timeout = ktime_add_ms(ktime_get(), 20);
         while (1) {
                 bool timedout = ktime_after(ktime_get(), timeout);

                 scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
                 if (scratch & O2_PLL_LOCK_STATUS)
                         break;
                 if (timedout) {
                         pr_err("%s: Internal clock never stabilised.\n",
                                mmc_hostname(host->mmc));
                         sdhci_dumpregs(host);
                         goto out;
                 }
                 udelay(10);
         }

         /* Wait for card detect finish */
         udelay(1);
         sdhci_o2_wait_card_detect_stable(host);

out:
         /* Cancel PLL force active */
         scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
         scratch32 &= ~O2_PLL_FORCE_ACTIVE;
         sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
}


[  +2,416948] mmc0: Internal clock never stabilised.
[  +0,000006] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  +0,000008] mmc0: sdhci: Sys addr:  0x00000000 | Version: 0x0000c001
[  +0,000007] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt: 0x00000000
[  +0,000007] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[  +0,000007] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000000
[  +0,000007] mmc0: sdhci: Power:     0x0000000f | Blk gap: 0x00000000
[  +0,000007] mmc0: sdhci: Wake-up:   0x00000000 | Clock: 0x00001003
[  +0,000007] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
[  +0,000007] mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
[  +0,000007] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  +0,000006] mmc0: sdhci: Caps:      0x21e608b2 | Caps_1: 0x00002077
[  +0,000007] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000064
[  +0,000007] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]: 0x00000000
[  +0,000007] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]: 0x00000000
[  +0,000005] mmc0: sdhci: Host ctl2: 0x00000000
[  +0,000001] mmc0: sdhci: ============================================
[  +0,020025] mmc0: Internal clock never stabilised.
[  +0,000008] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  +0,000019] mmc0: sdhci: Sys addr:  0x00000000 | Version: 0x0000c001
[  +0,000010] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt: 0x00000000
[  +0,000007] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[  +0,000007] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000000
[  +0,000007] mmc0: sdhci: Power:     0x0000000f | Blk gap: 0x00000000
[  +0,000008] mmc0: sdhci: Wake-up:   0x00000000 | Clock: 0x00001003
[  +0,000009] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
[  +0,000009] mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
[  +0,000010] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  +0,000007] mmc0: sdhci: Caps:      0x21e608b2 | Caps_1: 0x00002077
[  +0,000007] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000064
[  +0,000007] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]: 0x00000000
[  +0,000007] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]: 0x00000000
[  +0,000004] mmc0: sdhci: Host ctl2: 0x00000000
[  +0,000002] mmc0: sdhci: ============================================
[  +0,144927] mmc0: Internal clock never stabilised.
[  +0,000006] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  +0,000008] mmc0: sdhci: Sys addr:  0xfffe0058 | Version: 0x0000c001
[  +0,000007] mmc0: sdhci: Blk size:  0x00007040 | Blk cnt: 0x00000001
[  +0,000007] mmc0: sdhci: Argument:  0x80fffff1 | Trn mode: 0x00000013
[  +0,000008] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000004
[  +0,000008] mmc0: sdhci: Power:     0x0000000f | Blk gap: 0x00000000
[  +0,000008] mmc0: sdhci: Wake-up:   0x00000000 | Clock: 0x00000003
[  +0,000007] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
[  +0,000006] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
[  +0,000007] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  +0,000007] mmc0: sdhci: Caps:      0x21e608b2 | Caps_1: 0x00002077
[  +0,000007] mmc0: sdhci: Cmd:       0x0000063a | Max curr: 0x00000064
[  +0,000018] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]: 0x001d6f7f
[  +0,000009] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]: 0x00400e00
[  +0,000004] mmc0: sdhci: Host ctl2: 0x00000000
[  +0,000002] mmc0: sdhci: ============================================
[  +0,020026] mmc0: Internal clock never stabilised.
[  +0,000005] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  +0,000008] mmc0: sdhci: Sys addr:  0xfffe0058 | Version: 0x0000c001
[  +0,000007] mmc0: sdhci: Blk size:  0x00007040 | Blk cnt: 0x00000001
[  +0,000007] mmc0: sdhci: Argument:  0x80fffff1 | Trn mode: 0x00000013
[  +0,000007] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000004
[  +0,000008] mmc0: sdhci: Power:     0x0000000f | Blk gap: 0x00000000
[  +0,000006] mmc0: sdhci: Wake-up:   0x00000000 | Clock: 0x00000003
[  +0,000008] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
[  +0,000008] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
[  +0,000007] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  +0,000008] mmc0: sdhci: Caps:      0x21e608b2 | Caps_1: 0x00002077
[  +0,000047] mmc0: sdhci: Cmd:       0x0000063a | Max curr: 0x00000064
[  +0,000011] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]: 0x001d6f7f
[  +0,000012] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]: 0x00400e00
[  +0,000009] mmc0: sdhci: Host ctl2: 0x00000000
[  +0,000001] mmc0: sdhci: ============================================
[  +0,000136] mmc0: new high speed SDHC card at address 1234

[  +0,000252] mmcblk0: mmc0:1234 SA04G 3.68 GiB

[  +0,015905]  mmcblk0: p1



-- 
Best regards, Andy Lavr.

  CONFIDENTIAL NOTE

  This email (including any attachments) is intended only for the person or entity to which it is addressed
  and may contain confidential and/or privileged material.  Any review, retransmission, dissemination or other
  use of, or taking of any action in reliance upon, this information by persons or entities other than the
  intended recipient is prohibited. If you received this in error, please notify the sender immediately and
  delete the material completely from your system. E-mail communication cannot be guaranteed to be reliable,
  secure, error-free or virus-free. Accordingly, we cannot accept liability for any damage sustained as a
  result of any virus, error or incompleteness of this e-mail or any failure to deliver promptly or at all
  information exchanged between you and us by this means. If you suspect that this e-mail may have been
  intercepted or amended, please contact the sender. Any views or opinions expressed in this email are solely
  those of the author and do not necessarily represent those of our entity or related/associated entities.

