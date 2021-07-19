Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DDDC12002
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 09:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476416108B
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 09:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhGSIpx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhGSIpq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jul 2021 04:45:46 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A927C061574;
        Mon, 19 Jul 2021 01:27:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q15so2462876qkm.8;
        Mon, 19 Jul 2021 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KfeoXYA6FAtVnL9pqwpm6Rlfaw4SHNyLHqSR71j5cS8=;
        b=O+zM/7TQrw2PWROfcV5KenDe+huC/6iTcCfC7TZoCS2FAccbYtdUrHL7RvR8wCPXpv
         Iy8pW6YMY3xpX0kDdxQ4AEjKaXW7kCp8YTrjD0IvsUbMMZtg6HrH6NAnOHs88lpPifTO
         F4mD6j3TikLJ0Y9+ZNUtywj6MG5vzLfm8hw7x7bEymZUgwOuawoshGDXrc94jwOnTz/b
         za2bbIlgd0cGzDsqRhOlnOIqnYuc6SaFWpNqCs19pHaj+/DFeJYv1pz/sWSgtuoAVza9
         /Y5JMkySAYSAe83r6bHAM3CQvp9qm+uQPm9TSvHjqz2Go4BVFbnlH35+P9qHIplKrIV/
         6oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KfeoXYA6FAtVnL9pqwpm6Rlfaw4SHNyLHqSR71j5cS8=;
        b=Ah6WXzo6iT/pGh7euCANqUOC3TiwiNYCxdK5Nof+wdOcHA8EjI1Zx6dpFYG+xhoU++
         pSwUB2ow3NpXO+pTbs36MqOeS4D6t9HOi8LChyWu0DJS9CzvaAzXE0rPGEURlvix1i7A
         QI9EVPXRum4YtkYRS6hofT8C0vYfF6NuK91GERpnLmDCfkjPxOsw6UXmSUZ4B2yDL6Mz
         6qBCYFM8uBYZCZY65hy+M2r3bJiEq5CzCd51rGbycprUN3ExdTfSVJxwyo5i35rqHoNI
         anMamZ2rJG2Rx/JSQITxIXmCTj+oPSZuwsyeycyiw6KvzeaOTBXJ/hpS+uprfZZMhgdL
         RYbw==
X-Gm-Message-State: AOAM531gVfocDbf82qhCsH74Fv+5sY2T6mDy1WSxtN851cXHFIcccRZ+
        MPbTAG1B9oNalVUnGlm+8tODMYNlexspH1CAp2Y=
X-Google-Smtp-Source: ABdhPJxFNsUpfpnCq4bK4q3CccJePDsYucwThwxwfhLlAZhhvH9C2tqSBgEtIisAtECISVRJm9WpIDjcvFbnBv1hgCU=
X-Received: by 2002:a37:5646:: with SMTP id k67mr22482354qkb.309.1626686785944;
 Mon, 19 Jul 2021 02:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
 <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
 <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
 <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com>
 <CAJU4x8t+aOqq82EJMUNDpWiE3GPeyZkjFhy=AkmctcDE3mx6fA@mail.gmail.com>
 <CAPDyKFoSOk+4pmW60uGzKaYw3XOXshx+NSNqF_po=VLkK1-7Qw@mail.gmail.com>
 <CAJU4x8sMJSOnfBwDq7tVygRGFRw-SyrM1z8GBsF_Mur64-Y3_g@mail.gmail.com>
 <CAJU4x8uCAQoozeAqa6icVba61uo_eP+NtOxgnLzsXh6g2HeQdA@mail.gmail.com> <02c26834-f16e-e1c7-9ea9-36414d1c4403@intel.com>
In-Reply-To: <02c26834-f16e-e1c7-9ea9-36414d1c4403@intel.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Mon, 19 Jul 2021 17:26:14 +0800
Message-ID: <CAJU4x8u+BtU5iUna0tSws9rfUTJWfHZ21jteB5nk8e_2iMJgNg@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian Hunter <adrian.hunter@intel.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:27=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 14/07/21 5:15 am, Renius Chen wrote:
> > Hi Adrain,
> >
> > What do you think of this patch?
> > Or do you have any ideas or suggestions about the modification for
> > Ulf's comments?
>
> Perhaps try to define your power management requirements in terms of
> latencies instead of request size, and then take the issue to the
> power management mailing list and power management maintainers for
> suggestions.  You will probably need to point out why runtime PM doesn't
> met your requirements.
>

Hi Adrain,


Thanks for your advice.

Our purpose is only to improve the performance of 4K reads, and we
hope that it doesn't affect any other use cases. If we look into the
latencies, it may affect not only 4K reads but also some other use
cases.

Behaviors of ASPM is controlled by circuits of hardware. Drivers only
enable or disable ASPM or set some parameters for ASPM, and are not
able to know when the device enters or exits the L0s/L1 state. So the
PM part of drivers may not suit this case.

This patch could be simply divided into two parts:
1. Monitor requests.
2. Set a vendor specific register of GL9763e.

The part 2 is no problems we think. And Ulf thinks that the behaviors
of part 1 should not be implemented in sdhci-pci-gli.c. Do you have
any suggestions on where we can implement the monitoring?

Thank you.


Best regards,

Renius

> >
> > Thank you.
> >
> >
> > Best regards,
> >
> > Renius
> >
> > Renius Chen <reniuschengl@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >> Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=88=
7=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:16=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>>
> >>> [...]
> >>>
> >>>>
> >>>> Thanks, I understand what you mean.
> >>>>
> >>>> I simply searched for the keyword "MMC_READ_MULTIPLE_BLOCK" in the
> >>>> drivers/mmc/host folder, and found that in some SD/MMC host controll=
er
> >>>> driver codes such as alcor.c, cavium.c, ...etc, there are also
> >>>> behaviors for monitoring the request in their driver. What's the
> >>>> difference between theirs and ours?
> >>>
> >>> Those checks are there to allow the HWs to be supported properly.
> >>>
> >>>>
> >>>> And if the code that monitors the requstes does not belong the drive=
r,
> >>>> where should I implement the code and how to add some functions only
> >>>> for GL9763e in that place, in your opinion?
> >>>
> >>> Honestly, I am not sure what suits your use case best.
> >>>
> >>> So far we have used runtime PM with a default auto suspend timeout, i=
n
> >>> combination with dev PM Qos. In other words, run as fast as possible
> >>> to complete the requests in the queue then go back to idle and enter =
a
> >>> low power state. Clearly, that seems not to be sufficient for your us=
e
> >>> case, sorry.
> >>>
> >> Yes, the runtime PM, auto suspend, and PM Qos are all about the
> >> suspend/resume behaviors of the system or related to power states such
> >> as D0/D3 of the device. But these are totally different from the ASPM
> >> L0s/L1 for link states. Entering/exiting the ASPM is pure hardware
> >> behavior on the link layer and is not handled by any codes in
> >> drivers/mmc/core or drivers/mmc/host. We'd like to try to modify the
> >> patch by your opinions, but we are also confused about what or where
> >> suits our use case best. So we wonder how to start the modification
> >> and may need some suggestions to deal with the work, sorry.
> >>
> >> Thank you.
> >>
> >>
> >> Best regards,
> >>
> >> Renius
> >>
> >>
> >>> Kind regards
> >>> Uffe
>
