Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4ECC433E1
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D72215A4
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 11:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqZ5RFtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbgE1L75 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 07:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbgE1L75 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 07:59:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA6BC05BD1E
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 04:59:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q2so32982591ljm.10
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmUDbRdWnFX3Rob4B0QvCGfA3VJF+c7F7awpUudj+ms=;
        b=IqZ5RFtIvBjwnF1oMxfDsISc3/SF4HRrGWAVls6NFHl9jYWj5LhLFY+T+P/SLCDs/P
         Kj/LUDgERqB5366gEneqW0blH5AzlNjmQXcGhmp7spRhFlumHJ4m0Esqlgvq4at9sUcH
         eV92SEgJ7wyidXnCw9zbikM9VIDGIxDvAJDmqW+5ZTNxXDKrWBJ9NqeV1FhETBRDIiD5
         EzVI/QKFOk+c8HoZDbuWlftmetLHYNIIakPAkN9beIBq4x3CWhLW71Sx7oXtU4cTXl//
         JORy8FG5YOPaf3+0mhl9VRiQdUw/KITQNQvBpbziB03HaUtPlTJ8AvDecEgbfPc8uNuT
         JboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmUDbRdWnFX3Rob4B0QvCGfA3VJF+c7F7awpUudj+ms=;
        b=D+xGazGVyAyecAHrGc0DADRtKsfJ+9P3lTA6b64qekOlAHGbIyppJjDDzoM3EKLqSj
         U30/8j8EAxBJgRY0AXBDldiUhucEd+rSHky45D1RPi4lRJ25bI/UGcGyixb1mhQ4bQBj
         GFyByCuUsVesmEfZpEN2w7mbmSM8xDyvxj+Pq9IYpSnbps4yIrNw5nqwtTEv9o6kRskL
         CXZzSLW2Q7wn54u4MmfsB27//7jKQlzR/5j3Ey9kxmI8KDiLR/eQxSzwOF3onzTSIuW4
         0W4/cLZsAiHhakstX84sxgjybrax9vZQ/cxPh2ohKjw1sz6Zw3AJ+QTMFDgTYoKEDhWH
         9uhQ==
X-Gm-Message-State: AOAM5306G/oZUEAKBtZmxbLTs5Z9Znceb8uW8NoAbPCQzDAbd+9l68g0
        65/n0m1sclaGIyJjFQ6InTrv1OzWWBioRGK+iiVGQO/4
X-Google-Smtp-Source: ABdhPJw8GtTv+/sAxbto1YqqIvEBT46TYNkrZQQEeMUqRroN1vTaBL4E2sPM8eYDKji+VyijdekgVQK1D3k+XjeoHAA=
X-Received: by 2002:a2e:3818:: with SMTP id f24mr1244505lja.338.1590667195145;
 Thu, 28 May 2020 04:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200528081003.238804-1-linus.walleij@linaro.org> <SN4PR0401MB359826C471B9D331DC79E4EE9B8E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB359826C471B9D331DC79E4EE9B8E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 May 2020 13:59:43 +0200
Message-ID: <CACRpkdYXaq-JQ=buuSgFOT=DbqS7xsb0iXfc5aFYjg36hB2fTw@mail.gmail.com>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 28, 2020 at 10:26 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
> On 28/05/2020 10:12, Linus Walleij wrote:
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index b490f47fd553..324047add271 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -794,7 +794,8 @@ static struct elevator_type mq_deadline = {
> >       .elevator_attrs = deadline_attrs,
> >       .elevator_name = "mq-deadline",
> >       .elevator_alias = "deadline",
> > -     .elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE,
> > +     .elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE |
> > +     ELEVATOR_F_SINGLE_HW_QUEUE,
>
> That indentation looks a bit odd to me but for the general concept

Yeah it's what the EMACS default "linux" indentation suggest if I
put the flag on a new line, but I can adjust to whatever the block
maintainers suggest.

> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Thanks man!

Yours,
Linus Walleij
