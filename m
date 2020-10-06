Return-Path: <SRS0=uM1y=DN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F12AC4363D
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 13:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ED62078E
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 13:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdFbbEab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJFNp2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Oct 2020 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFNp2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2020 09:45:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA8BC061755;
        Tue,  6 Oct 2020 06:45:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so7993326pgm.11;
        Tue, 06 Oct 2020 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5tbBktaYCveUyqUKP7C5+yx8eshWk6kNr6MFBtqaYs0=;
        b=tdFbbEab7P6ctnOCztAANhuNGfm0C/s+XpQayT+qel735y0nuTSQeZEui67TMEJKO5
         T1qaKdEgNKghpD6QPcfuqQxD9wJomEOMw6TIcsjv1cJasXB5IxHYbFA2Ee8aMWFTjJ5H
         k4QNJ2puGJPlj7rqNBI90PSx0qvHIl2R7QHn7sZG8WX0g83Nd7dRtzpsmDLFiYBI2olt
         DhmLNuHtiKwF8jOru8FkRFegFa8XtfNYrxyHHxDxuLIQBpiGUdpq3IILRshj4fvDEmOV
         8C0dOPV/bfkWx+6l205vAv0pG06xIg8FjgoU9WKBsb77UJEOGVNdFEbFaA0SrORVWgMd
         9uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5tbBktaYCveUyqUKP7C5+yx8eshWk6kNr6MFBtqaYs0=;
        b=WLPp2SsKqjVD1k0SND57J4oy2bmvpc0j41ewkGamMVtlp5dKoc9yY3XYO+05ka3oKR
         7To5j3WIo7jfztrEnrnEKlaURRJCnvKOvuzSiogB1tFnL6/HgbMO0uxyBhvo+2ygu2en
         GaiFRme/QDg6WAE7jI5Dnq2jMw9qtsF0t9HpZOezQGikbBy4nzJP+uovDwbar6+XRbIY
         NBPM0c7HgJDaHTaC6O7lYjQu+BQIqsTTeMpbRHul3IsZCQDBPN9sYrrHbk/PslP0+18F
         /f1CiAwFHgi0QMlsLqH6SeQEKLLJdEBlTLZg0AzD8Y5je0Bf1N3MZXKXtJLVF665BjHz
         8Otg==
X-Gm-Message-State: AOAM533aR+0NjxT1WWJ8VE7QOWbNFv9ImGsaFJvzgv7DddlnZHggWBN/
        BOaYsjImpxjw/RXUJBpHkvNnzxkzeLPlGHtI
X-Google-Smtp-Source: ABdhPJy8NH8Q6FBcZVTf/neYX6uRWoUFtx1mZx7iecYevo8Bf//iUTH5fR7Nsg1WtwWkexNTbJW4ug==
X-Received: by 2002:aa7:8dc7:0:b029:151:2237:52c5 with SMTP id j7-20020aa78dc70000b0290151223752c5mr4649146pfr.32.1601991927399;
        Tue, 06 Oct 2020 06:45:27 -0700 (PDT)
Received: from ?IPv6:2402:b801:2840:8200:a50f:f34d:264:5cdf? ([2402:b801:2840:8200:a50f:f34d:264:5cdf])
        by smtp.gmail.com with ESMTPSA id h12sm3703548pfo.68.2020.10.06.06.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 06:45:26 -0700 (PDT)
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20201002164915.938217-1-jbrunet@baylibre.com>
 <CAPDyKFo6T_P+TQQZSzFgHwLeE08f146KxKBpAutv209MXq0mjA@mail.gmail.com>
 <87wo052grp.fsf@nanos.tec.linutronix.de>
 <87v9fn7ce2.fsf@nanos.tec.linutronix.de>
From:   Brad Harper <bjharper@gmail.com>
Message-ID: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com>
Date:   Wed, 7 Oct 2020 00:45:20 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87v9fn7ce2.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I'm happy to test anything on a range of amlogic hardware with standard 
/ rt and  multiple mmc devices.  Ill test Jerome's patch in next 24 
hours to report the results.

On 6/10/2020 11:43 pm, Thomas Gleixner wrote:
> On Mon, Oct 05 2020 at 10:55, Thomas Gleixner wrote:
>> On Mon, Oct 05 2020 at 10:22, Ulf Hansson wrote:
>>> On Fri, 2 Oct 2020 at 18:49, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>> IRQF_ONESHOT was added to this driver to make sure the irq was not enabled
>>>> again until the thread part of the irq had finished doing its job.
>>>>
>>>> Doing so upsets RT because, under RT, the hardirq part of the irq handler
>>>> is not migrated to a thread if the irq is claimed with IRQF_ONESHOT.
>>>> In this case, it has been reported to eventually trigger a deadlock with
>>>> the led subsystem.
>>>>
>>>> Preventing RT from doing this migration was certainly not the intent, the
>>>> description of IRQF_ONESHOT does not really reflect this constraint:
>>>>
>>>>   > IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>>>>   >              Used by threaded interrupts which need to keep the
>>>>   >              irq line disabled until the threaded handler has been run.
>>>>
>>>> This is exactly what this driver was trying to acheive so I'm still a bit
>>>> confused whether this is a driver or an RT issue.
>>>>
>>>> Anyway, this can be solved driver side by manually disabling the IRQs
>>>> instead of the relying on the IRQF_ONESHOT. IRQF_ONESHOT may then be removed
>>>> while still making sure the irq won't trigger until the threaded part of
>>>> the handler is done.
>>> Thomas, may I have your opinion on this one.
>>>
>>> I have no problem to apply $subject patch, but as Jerome also
>>> highlights above - this kind of makes me wonder if this is an RT
>>> issue, that perhaps deserves to be solved in a generic way.
>>>
>>> What do you think?
>> Let me stare at the core code. Something smells fishy.
> The point is that for threaded interrupts (without a primary handler)
> the core needs to be told that the interrupt line should be masked until
> the threaded handler finished. That's what IRQF_ONESHOT is for.
>
> For interrupts which have both a primary and a threaded handler that's a
> different story. The primary handler decides whether the thread should
> be woken and it decides whether to block further interrupt delivery in
> the device or keep it enabled.
>
> When forced interrupt threading is enabled (even independent of RT) then
> we have the following cases:
>
>    1) Regular device interrupt (primary handler only)
>
>       The primary handler is replaced with the default 'wake up thread'
>       handler and the original primary handler becomes the threaded
>       handler. This enforces IRQF_ONESHOT so that the interupt line (for
>       level interrupts) stays masked until the thread completed handling.
>
>    2) Threaded interrupts
>
>       Interrupts which have been requested as threaded handler (no
>       primary handler) are not changed obvioulsy
>
>    3) Interrupts which have both a primary and a thread handler
>
>       Here IRQF_ONESHOT decides whether the primary handler will be
>       forced threaded or not.
>
>       That's a bit unfortunate and ill defined and was not intended to be
>       used that way.
>
>       We rather should make interrupts which need to have their primary
>       handler in hard interrupt context to set IRQF_NO_THREAD. That
>       should at the same time confirm that the primary handler is RT
>       safe.
>
>       Let me stare at the core code and the actual usage sites some more.
>
> Thanks,
>
>          tglx
>
>
>
>
>
>
