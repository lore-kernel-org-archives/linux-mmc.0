Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E52C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Oct 2022 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJJOC2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Oct 2022 10:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJOC2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Oct 2022 10:02:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625113CBD6
        for <linux-mmc@vger.kernel.org>; Mon, 10 Oct 2022 07:02:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g28so10843025pfk.8
        for <linux-mmc@vger.kernel.org>; Mon, 10 Oct 2022 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NNn3dnfIc//C5wbMysrQE6z6CNvVbu0p6YggJ7tf38=;
        b=byf2x9651vo4lcyF35qEel62tp7si+6VYBbBD7Ee4gGTyoBazyuSpHYutfiQllLlYq
         vO55hgibRn6oHLRoHXDzHFbhfuJl3H4AQmI+oyvAr5f0hyHCGcO7Exa4+z0FOgszJmTW
         /E6f67OPBClNuvGvGoP6dmvJkQ/D6vE2HPukzmTJRWTEcu5Bhu50iOPYzukhbn8rPDmE
         jxS7jvyVsCj91gSJFfg9HagzT9nykn3nnKqjlDB80nGHG14kj/wFzZVUAZV19lkEqA5x
         kVvgSuFToCAIt3OItmJGLT101eo+zUTkfQ+/65FK9ptgLb1/qCE9/s0rA/iZ1ltbMn6e
         vhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NNn3dnfIc//C5wbMysrQE6z6CNvVbu0p6YggJ7tf38=;
        b=rhF5h5xu+GxbeVOlXGlSNd/2Lz9KJ6b8Xte4/tD4wKx5ixmHHaTNS6J3N5OUwuXWYt
         pAQ1rvlpnuZKe+29FhUJH7xOf3H9QhWKQRhA+svCBOGlUgcE61XvsWLQNFv4lPqAAB0z
         r6f7Za8/AAQp6DFpJY+v+bOOhJCXWkid5GmtS+eAQJNE+U0qfcih9ba9CF1taJoVZV9D
         5c9VIgFHXMwCWlcGIwoNqkya4KpXvclC/d2Np8ot0zI+bHTylok1iU3CW0r9f1bMJU+F
         y+kea4/zZ/cQO2D0UC9OvKk6LKiN8d+Xr7ibUqf1rCU9f4s/bC1XrljSjtokBgUOGlbl
         VNBQ==
X-Gm-Message-State: ACrzQf32Ur07DVfHZDVJJW/3fE5Zrfb9KlAaoeIOGDhL7pwIU8pZnHMn
        L88ctUN6vzDpv+RwSgFyxh8sbenSAekGe8iru153LQ==
X-Google-Smtp-Source: AMsMyM6/NCZyYzhl0pwlzjn5ERQz0dKo0AF+9b0gEEzbigVV8q/ld69kNSH3AFBt5fqebf1SB1mNF6p35++a3XB0p3Y=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr17339804pgk.595.1665410546740; Mon, 10
 Oct 2022 07:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <003d34d1643242488b533dc14f69830f@hyperstone.com>
 <e6acc89d-7d17-62ee-d67a-b78b1cdcd085@intel.com> <27343e2a17d1481f9a62d710480bc041@hyperstone.com>
 <59847aad-6339-9a06-f743-257a4bc4229a@intel.com>
In-Reply-To: <59847aad-6339-9a06-f743-257a4bc4229a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Oct 2022 16:01:49 +0200
Message-ID: <CAPDyKFrJXvsp3uNu+Mso9wqE4+d7b_ZtrCsJqoBhnFzYds8m5Q@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] mmc: block: Remove error check of hw_reset on reset
To:     Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <cloehle@hyperstone.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 Oct 2022 at 14:36, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 10/10/22 11:08, Christian L=C3=B6hle wrote:
> >
> >>
> >> -----Original Message-----
> >> From: Adrian Hunter <adrian.hunter@intel.com>
> >> Sent: Samstag, 8. Oktober 2022 10:38
> >> To: Christian L=C3=B6hle <CLoehle@hyperstone.com>; Ulf Hansson <ulf.ha=
nsson@linaro.org>; Linux MMC List <linux-mmc@vger.kernel.org>; linux-kernel=
@vger.kernel.org
> >> Subject: Re: [PATCHv2 1/2] mmc: block: Remove error check of hw_reset =
on reset
> >>
> >> On 7/10/22 18:42, Christian L=C3=B6hle wrote:
> >>> Before switching back to the right partition in mmc_blk_reset there
> >>> used to be a check if hw_reset was even supported.
> >>> This return value was removed, so there is no reason to check.
> >>>
> >>> Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in
> >>> mmc_hw|sw_reset()")
> >>> Cc: stable@vger.kernel.org
> >>>
> >>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> >>> ---
> >>> -v2: Do not attempt to switch partitions if reset failed
> >>>
> >>>  drivers/mmc/core/block.c | 28 +++++++++++++---------------
> >>>  1 file changed, 13 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c inde=
x
> >>> ce89611a136e..8db72cba2bbe 100644
> >>> --- a/drivers/mmc/core/block.c
> >>> +++ b/drivers/mmc/core/block.c
> >>> @@ -991,29 +991,27 @@ static int mmc_blk_reset(struct mmc_blk_data *m=
d, struct mmc_host *host,
> >>>                      int type)
> >>>  {
> >>>     int err;
> >>> +   struct mmc_blk_data *main_md =3D dev_get_drvdata(&host->card->dev=
);
> >>> +   int part_err;
> >>>
> >>>     if (md->reset_done & type)
> >>>             return -EEXIST;
> >>>
> >>>     md->reset_done |=3D type;
> >>>     err =3D mmc_hw_reset(host->card);
> >>> +   if (err)
> >>> +           return err;
> >>
> >> This could be a potential source of data corruption.
> >>
> >> There is no guarantee that a subsequent I/O will fail just because the=
 reset failed.  Reading / writing the wrong partition would be disastrous, =
so we should always try to get back to the correct partition.
> >>
> >> I haven't looked at the possibility of just flagging the partition as =
invalid - need to be sure any subsequent I/O attempts still go through a pa=
th that switches the partition.
> >
> > I can see where youre coming from, but similarly a failing mmc_blk_part=
_switch doesn't imply all subsequent IO will fail.
> > Flagging the partition as invalid can be seen as rendering the system t=
o a potentially useless state, which is a bit overboard for e.g. one CRC7 f=
ailure on the switch.
>
> I wasn't clear sorry.  I meant setting main_md->part_curr to a value
> that doesn't match any partition, thereby forcing the next I/O to
> switch partition first.

If I understand correctly, you are suggesting to ignore the return
code from mmc_hw_reset() and then always try to switch to the correct
partition. If we end up failing to switch the partition, then we
should set an invalid value in main_md->part_curr and return an error
code?

>
> > Not sure yet what the ideal behavior is, but either way I would go with=
 v1 1/2 and v2 2/2 for now? That already fixes imo the most relevant potent=
ial data corruptions. (successful reset -> no switch)
> > Then we can come up with a a good handling for mmc_blk_reset or even ar=
ound mmc_blk_part_switch.
> > Or what do you suggest?
>
> What about what I just described above.
>

It seems reasonable to me (assuming I have understood correctly).

One additional thing though. I would appreciate some comments in the
code, so it becomes clear of what goes on.

Kind regards
Uffe
