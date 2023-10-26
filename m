Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEC0C25B6B
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Oct 2023 10:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjJZKER (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Oct 2023 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZKEP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Oct 2023 06:04:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCBC196
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 03:04:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c603e2354fso142375266b.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698314652; x=1698919452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e+ROHMZDFQr94Blxn0koXeytsspnhzGh0xCKS0RGHlQ=;
        b=CD2NxJ+aToeJcqZ+cKQv1df5RrnILXLACKXzoM6EKjygvszeBsFm70/lavluPpDj0c
         43whzG2mkMsS8VgqG0iw132MEhJlwAhFlQ8hG1P7ZBphCcPM7/QmNW5ndBqB+se3w3A4
         V2XDMJqiQG5xY/Ar4ivW6AZs0fQDzCSakRuE8VdzVqMZ+IGzGSZTJVw+ZoFF3KQVq/fL
         AGQUZEpw9G8v6/bgfgPa/Itn3PjVJ20byJk1g3igm6WqCRhtsbToRwOu0LgG6F9afmt4
         Ku+WyEbu8L7H21M8KX+6SXFNLiaChGCD/9uzCuu5iY8pzZ0a5za+PNu27XAk4OBItXfs
         4R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314652; x=1698919452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+ROHMZDFQr94Blxn0koXeytsspnhzGh0xCKS0RGHlQ=;
        b=lRaL/vqaRHnoYiokk60ZQlEia+MORjPSAy22oH30sftcOXWNk0dC/x2szQW2UwFNMX
         wWbhdn6QelwDxAP/TI0CuXABtWqsvmUZT+ayx4FjCKiT+X0J8Dt9p8ju2GYzKdzQ6Cbw
         /tra8JCCVuCRHgsUYC66vV8VpbGARG4G7WJ7eeetmbJsjm0J+IyGq51NzSXGqThIocW9
         Z6oF/EolLIK5yJ4zr188wA0mdoDXFFypOa/hhHNMOBpMnxVT9xWSDSM9BXqzaJMeNJGe
         JwTiAlUJeoykK50Mou9X2Y2qs4576rFaWC3W05exfqpPAZzsXfHdNZ916YadzTVplBT3
         YKSQ==
X-Gm-Message-State: AOJu0YxH/oP01yeBgvSsejZSI5Gca8rdjQJmzDKYaHoGO9SOW1EjOX32
        FPF6VHsfotz6R5r4NMPtJPVaT5rzHWRIDKuQjzschQ==
X-Google-Smtp-Source: AGHT+IETdR59B8bvGjFmmSMOPSSV9qbuSa+F56wGfBT8gP9VeLIZyyL8kpG/mc7o1krzwvHJBrdR0iIKaihZYdlw8P8=
X-Received: by 2002:a17:907:97c8:b0:9b6:3be9:a8f with SMTP id
 js8-20020a17090797c800b009b63be90a8fmr2102098ejc.20.1698314651723; Thu, 26
 Oct 2023 03:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231025113035.1881418-1-avri.altman@wdc.com> <afdada50-cdcb-4edb-a026-c872e1914e43@intel.com>
In-Reply-To: <afdada50-cdcb-4edb-a026-c872e1914e43@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Oct 2023 12:03:35 +0200
Message-ID: <CAPDyKFr-jqNtV8oD90TeJAfdOfUj1-CMZaMcQEFbJCqOHxp_yA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Oct 2023 at 10:38, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 25/10/23 14:30, Avri Altman wrote:
> > Field Firmware Update (ffu) may use close-ended or open ended sequence.
> > Each such sequence is comprised of a write commands enclosed between 2
> > switch commands - to and from ffu mode.
> >
> > Some platforms generate auto command error interrupt when it shouldn't,
> > e.g. auto-cmd12 while in close-ended ffu sequence.  I encountered  this
> > issue while testing fwupd (github.com/fwupd/fwupd) on HP Chromebook x2,
> > a qualcomm based QC-7c, code name - strongbad. Instead of a quirk, make
> > sure it disable auto-cmd12 while close-ended ffu is in progress.
>
> I think I misunderstood this because I was thinking that auto-cmd12
> was being used with an open-ended sequence, and that it wasn't
> working with FFU.  However it seems mmc-utils is using a closed-ended
> sequence.
>
> It looks like the the host controller driver doesn't know that,
> because the ioctl interface does not use mrq.sbc and the
> SET_BLOCK_COUNT command is sent separately.  Then when the MULTI_WRITE
> command is issued, the host controller driver treats it as open-ended
> and will enable auto-cmd12 if the controller supports it.
>
> If that is the case, it would be better to fix the ioctl handling
> and make it use mrq.sbc instead of issuing SET_BLOCK_COUNT separately.

Agree!

[...]

Kind regards
Uffe
