Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27896CDB474
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Oct 2023 04:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjJQEfh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 00:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjJQEff (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 00:35:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291F83
        for <linux-mmc@vger.kernel.org>; Mon, 16 Oct 2023 21:35:33 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CF43F3FA5B
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 04:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697517331;
        bh=iKSzw0H7imvFnQsSbXS4s9q/+KmLgFfqqX5RqZH9/7g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mXWxCtu4VYDoH0Y4rZGGzv+kiJ3a77Uo1RPh3iMH1RNzEFijCF/WzKQYi6gvQyMwo
         eR9KEr2c+t2RhS7xYclxh6H3s9UnQL6zfPAo8eMheEjrYb/QObYI74jl5JNg27CBAl
         bC903xQYCNB7rQXtUArBfa11NIe+iIk9UYeZKiZVhJJcnYhzZ+BiLzgfBVEsKEM5LH
         6dHFRLpzcMONViZ20lz1ecTI8JaZJSgu0P3DV8DWVkogH/NCmPp68a7e19MudzBNGF
         DDmX9SI6DKUmKMgZJ3RYM3tBH8Z27iVAu0HitJAUZXG3ygA3WvuqBTR0Krp8t6HFYr
         gfIRKhhygNglA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6bde4f405f9so1411312b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Oct 2023 21:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697517330; x=1698122130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKSzw0H7imvFnQsSbXS4s9q/+KmLgFfqqX5RqZH9/7g=;
        b=fspxKCnMDoQ6a+gJf5QzI8UxNigYZ+dbMKXW4okSPpAhpiz2ueG3h5UL6PpyQvopBb
         vtGqkVOz3nPl2BubySuawA98SNkdhkWNeA4v5XcPoEZ8XK4dCgWo1PaS9+eTI/lE8FI1
         8sNFAyy2WbuyStHC3QiKs7ch2iVIT88yNlJIiAoJ2NyHZT+Ne8xeJnd40f2g5MBaIfxs
         4UJHzhmEEgc/YblJYJLUYJH3vG0N/eqIPXJidskMR6MKZjx1bNaaAMKoyE/nrfZuKIFz
         u2mNT6nJZvItnDh/3MzYy9mT1lfGOQaUAvNE5ZDBBCrS1w4nsXMHpQWGI6eq8K3GvfdE
         Wm5g==
X-Gm-Message-State: AOJu0Yxzj+QdwulwUl+ADgksgl9x2N3aIr2WXBbJwr2oETYCdWfE8lSS
        RRGjq9vYRnnGJVZkBpPJaugjHTjgMu81N3ajfvjAyWuEIUbZ7OiGDAK7yz6gBZ0SJlkqguh/svq
        hRxsB+fFAUJXtmC5pruojYjKBmalMCAn7zpriVlpV7N9jmsYt+AfvrQ==
X-Received: by 2002:a05:6a20:748d:b0:13f:1622:29de with SMTP id p13-20020a056a20748d00b0013f162229demr1084710pzd.7.1697517330292;
        Mon, 16 Oct 2023 21:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFLDvl8FYUD59smCq9rBmVwBQHVhTMqWbcNJ5kiwZ/K6MdL50lc1s9Gp+P/vxymrzoENEc8vjZITD/t6KXXlM=
X-Received: by 2002:a05:6a20:748d:b0:13f:1622:29de with SMTP id
 p13-20020a056a20748d00b0013f162229demr1084694pzd.7.1697517329969; Mon, 16 Oct
 2023 21:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231016040132.23824-1-kai.heng.feng@canonical.com> <20231016093210.GA22952@wunner.de>
In-Reply-To: <20231016093210.GA22952@wunner.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 17 Oct 2023 12:35:18 +0800
Message-ID: <CAAd53p7gbWSkRbng205z2U0_kU42JeFw8qThcBuXuVwCC+Y_VQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on PCIe
 Link Down
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, linux-pm@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ricky Wu <ricky_wu@realtek.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Oct 16, 2023 at 5:32=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Mon, Oct 16, 2023 at 12:01:31PM +0800, Kai-Heng Feng wrote:
> > When inserting an SD7.0 card to Realtek card reader, it can trigger PCI
> > slot Link down and causes the following error:
>
> Why does *inserting* a card cause a Link Down?

Ricky, do you know the reason why Link Down happens?

>
>
> > [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > [   63.912118] BUG: unable to handle page fault for address: ffffb24d40=
3e5010
> [...]
> > [   63.912198]  ? asm_exc_page_fault+0x27/0x30
> > [   63.912203]  ? ioread32+0x2e/0x70
> > [   63.912206]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> > [   63.912217]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> > [   63.912226]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> > [   63.912234]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> > [   63.912243]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> > [   63.912246]  pci_pm_runtime_idle+0x34/0x70
> > [   63.912248]  rpm_idle+0xc4/0x2b0
> > [   63.912251]  pm_runtime_work+0x93/0xc0
> > [   63.912254]  process_one_work+0x21a/0x430
> > [   63.912258]  worker_thread+0x4a/0x3c0
>
> This looks like pcr->remap_addr is accessed after it has been iounmap'ed
> in rtsx_pci_remove() or before it has been iomap'ed in rtsx_pci_probe().
>
> Is the card reader itself located below a hotplug port and unplugged here=
?
> Or is this about the card being removed from the card reader?
>
> Having full dmesg output and lspci -vvv output attached to a bugzilla
> would help to understand what is going on.

I don't have the hardware so we need Ricky to provide more information here=
.

Regardless of the cardreader issue, do you have any concern on the patch it=
self?

Kai-Heng

>
> Thanks,
>
> Lukas
