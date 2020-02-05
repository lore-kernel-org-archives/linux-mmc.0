Return-Path: <SRS0=4knG=3Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348B6C35249
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 07:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F4D20702
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 07:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xoi0HebK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgBEH5R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Feb 2020 02:57:17 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37838 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgBEH5R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Feb 2020 02:57:17 -0500
Received: by mail-vk1-f195.google.com with SMTP id o200so289127vke.4
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 23:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UF7C0KGOuuZH/Pa9RE82FQ5XfRZJuv0CUeDiIFZHtew=;
        b=Xoi0HebKV4W0f6QPUDIeGmXBurzLfXC9CzA5CF/brhUWR4OyPdiq7S0IzRudTUKVjK
         gcaD5EOmuHxLuxOWjsN/POanB0RizPpPSipIDSX4TElw1CW4o3W5MK//p0UmBXC9/HyD
         IHQrHOEXo++qyvabEZU1ggN9Eu7ZJYSZuzWhLA0VPnlqKZsn3pDU/1hrartjIt4HJQtP
         DED23VoJ4YubwLIZenAgBoBHRY1/JDdOybxQLZuglIXyyLLdvo1dn9RUxqen6Jzyaa/k
         u9K15mTkufgPXwWN8skaUXlfGudQjUnPib126XtANlGUDNkw0Ju2po0MrUavbn06fMm3
         4y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UF7C0KGOuuZH/Pa9RE82FQ5XfRZJuv0CUeDiIFZHtew=;
        b=XOrhSOG3EsVbDBzO0JaKmKrx9YiQAJkvBRQhxKi+NjTIdN7kmDBj5nBzXYAGsh6Bd3
         aB55xN9AtTkusDT7rSeKcWaIqW/4PJ84dc6k4Rg2WfERDoSAiUAmptKfA/i7IvWUPMkO
         dbffx0+7zcPwlvbNi07DuKASDgp1L6l2eJOCObOI6yPEAbNSfdVhF4v8Fs7ZqDsuTneF
         9l6wPZQLQfWN2sz8L3qBCS4QC9oYYCzHe8ZhDFn3O6vJRoUTzjKG6Ag2Ozh1qNajRQhO
         TohFR7iFVKj71P9+NjDD8zll4NnrEO22s+9itiEP3Yv0twFeUqe8FW/a7EpXO5HP3ceo
         fjbg==
X-Gm-Message-State: APjAAAVtBzev7BZO+N2HUT+AFHJwrg78MEErfLbfMbBryVu0su4BzFJw
        DYo/uxF4JtsuYa9SPAkFy3XKnJLJHrwr+9TcDacfNg==
X-Google-Smtp-Source: APXvYqyQ+2wN1IZuMG93KSV30qKNQZhlQtsg3QYjIqqpsmz2HSvKs8bD9Tprh9NKF/EMOadc07ba8AC0AyiHbCT2Ctg=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr870431vkd.101.1580889434863;
 Tue, 04 Feb 2020 23:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20190922102341.GO25745@shell.armlinux.org.uk> <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
 <AM7PR04MB688507B5B4D84EB266738891F8320@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <50fe98f2-9ee6-c0fb-d246-e3d6b4b2cec5@arm.com> <AM7PR04MB6885C2B7186DE54E97C6E38BF8020@AM7PR04MB6885.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB6885C2B7186DE54E97C6E38BF8020@AM7PR04MB6885.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Feb 2020 08:56:38 +0100
Message-ID: <CAPDyKFr6jYkfER+LDBDvSXj0PFg8rnU7REhFrSL+2yW_q-P8tw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA coherence
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Leo Li <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 5 Feb 2020 at 06:56, Y.b. Lu <yangbo.lu@nxp.com> wrote:
>
> Hi Robin,
>
> Thanks lot for your suggestion. I prefer your fix-up patch to treat PowerPC as a special case.
>
> Hi Adrian and Uffe,
>
> Do you think it is ok? Should I help to re-send that patch to mmc mailing list for reviewing.
> Thanks.

commit dabf6b36b83a18d57e3d4b9d50544ed040d86255
Author: Michael Ellerman <mpe@ellerman.id.au>
Date:   Sun Jan 26 22:52:47 2020 +1100
of: Add OF_DMA_DEFAULT_COHERENT & select it on powerpc

This one is already in Linus' tree, I suppose that is sufficient.

[...]

Kind regards
Uffe
