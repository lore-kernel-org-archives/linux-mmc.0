Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DABEE49AB
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Aug 2023 10:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjHUKDs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Aug 2023 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjHUKDr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2023 06:03:47 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564C6CE
        for <linux-mmc@vger.kernel.org>; Mon, 21 Aug 2023 03:03:45 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48d0eb04c8cso267914e0c.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Aug 2023 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692612224; x=1693217024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5JLVI5Xk4lK0PmKDVbDYnuovDxJaPByMRBhbwCuLSg=;
        b=qj7PwLlimoyEEuIVU9stZFmVBicsc8tADQ/RXFCz3gGIkRnwydP8/AuZYG4d0Guqyb
         7l9AY8ip21KHQnjIPSia3MC3FXMvTgurcTCeb+QsLs8WHSSplCm7PcP3uuEr2+g6aXfu
         s21QcOu6/axpOPINhRWlwdpaLDhqpmTaaH5fc/4lHa5SuCc7vBJSH9xpilpUNTbpxAGL
         TtPm1ZTv8JVsN2l29DE6EYzEE1mz4nwDU/W6vJvsdLht66L6HmP1RM26gTIpVCvX5W3P
         SlvYY2w+qz7XWhXf81jQSb6fFljG8MRHiYElRgD0ZDzZXL4QPD04iNoedDJgYh64rSCt
         tg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692612224; x=1693217024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5JLVI5Xk4lK0PmKDVbDYnuovDxJaPByMRBhbwCuLSg=;
        b=kCNEJlVzTylnqKKjgrO2zJ7xX2hgnt8SQx5y6qe43t5/WBWxKfp5XhsCwvtA2phFMZ
         CqoiW9EoktvkvCK+m0t/A7Jy1rxHj5Di2BvKZH7SeBLPH24Lioo6qufETI0r8a0/280A
         4ZeG+zhSxTmOc2344QvTvgyN2SzaAMMwMFzZCzeOT91jZsB75DMpWTbvkHie2M/2U3Hz
         riS4XMaK5RsoJQ/qSl5GUp0dDB1XTOysRTgAXyIh+am74/X2x39jcKgOJR0oQiwX3OGg
         xCJiTcdkb2pjiYF3zqb4xR0iiDfrO5noKmD4Gg4LKunvKXpBUOBo4VnistfLRGxnQ+TC
         AJ1w==
X-Gm-Message-State: AOJu0Yy1MYQuM3KIkilxBNSBw+LSboz/cDwj7uEuJJr+d4KHWPCopKtK
        kMOlpn8bduYaoSl//QYx6rnlz2OjCw5IHKmW67xodg==
X-Google-Smtp-Source: AGHT+IFwiNZUqz6PPoYS8ZMAeA3/YxgChg4za63k/bbsfq4tHpjrYnu95jtmavoOcdLv9S583LN3OQNCe+Au9W2Nzw8=
X-Received: by 2002:a67:b603:0:b0:443:b014:e5af with SMTP id
 d3-20020a67b603000000b00443b014e5afmr2173372vsm.6.1692612224334; Mon, 21 Aug
 2023 03:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
 <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com> <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
In-Reply-To: <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 21 Aug 2023 15:33:33 +0530
Message-ID: <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com>
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
To:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jerome Forissier <jerome.forissier@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-scsi@vger.kernel.org,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 8/17/23 01:31, Shyam Saini wrote:
> >
> > Hi Ulf,
> >
> >> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
> >> <shyamsaini@linux.microsoft.com> wrote:
> >>>
> >>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>>
> >>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
> >>> originally proposed by [2]Thomas Winkler ]
> >>>
> >>> A number of storage technologies support a specialised hardware
> >>> partition designed to be resistant to replay attacks. The underlying
> >>> HW protocols differ but the operations are common. The RPMB partition
> >>> cannot be accessed via standard block layer, but by a set of specific
> >>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> >>> partition provides authenticated and replay protected access, hence
> >>> suitable as a secure storage.
> >>>
> >>> The initial aim of this patch is to provide a simple RPMB Driver whic=
h
> >>> can be accessed by Linux's optee driver to facilitate fast-path for
> >>> RPMB access to optee OS(secure OS) during the boot time. [1] Currentl=
y,
> >>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
> >>>
> >>> A TEE device driver can claim the RPMB interface, for example, via
> >>> class_interface_register(). The RPMB driver provides a series of
> >>> operations for interacting with the device.
> >>
> >> I don't quite follow this. More exactly, how will the TEE driver know
> >> what RPMB device it should use?
> >
> > I don't have complete code to for this yet, but i think OP-TEE driver
> > should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
> > specific implementation for RPMB operations.
> >
> > Linux optee driver can handle RPMB frames and pass it to RPMB subsystem
> >

It would be better to have this OP-TEE use case fully implemented. So
that we can justify it as a valid user for this proposed RPMB
subsystem. If you are looking for any further suggestions then please
let us know.

> > [1] U-Boot has mmc specific implementation
> >
> > I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
> > CFG_RPMB_FS_DEV_ID=3D1 for /dev/mmcblk1rpmb,
>
> Correct. Note that tee-supplicant will ignore this device ID if --rmb-cid
> is given and use the specified RPMB instead (the CID is a non-ambiguous w=
ay
> to identify a RPMB device).
>
> > but in case if a
> > system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
> > should be declared as secure storage and optee should access that one o=
nly.
>
> Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
>
> > Sumit, do you have suggestions for this ?
>

I would suggest having an OP-TEE secure DT property that would provide
the RPMB CID which is allocated to the secure world.

-Sumit

>
> --
> Jerome
