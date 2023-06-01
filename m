Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632A4C77B7A
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jun 2023 05:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFAFcN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jun 2023 01:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFAFcM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2023 01:32:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C80129
        for <linux-mmc@vger.kernel.org>; Wed, 31 May 2023 22:32:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f50a8f6dd7so389369e87.2
        for <linux-mmc@vger.kernel.org>; Wed, 31 May 2023 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685597529; x=1688189529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsI/5WLiHlcp0ZEEt3H/cNP/MuQhNAeZoQaqtMmhWNQ=;
        b=H+UnM8kWWRu5RWrI0KNNuViptqIvOW5zcJGzBaZVFz5u1WPqYJXCJc17Qscomw3p6F
         dueFhvI1Neba5nB4Sott68NEtF/E6W9h9s7avVEcUnaAlcSsxIzJ9g+FN3IGoppPPwfQ
         kgDux/S4X/2WMZOKI69iGFK03nIwzJ3WtLaPca8zqU7iSp++rOSVP2lZJbCKUWr32eyf
         LlUyC73afA/whcbyU+96OP0rKkDhmp4EVsngkdcGENWbelRUI3az4Pqeq8bfU6I9ayvy
         UlA4j01jegpkBBOlrxxOnlS3YWzus6MeV3yehNEiIXQIMSYHTR74iF5jw/CFznmiYghR
         CgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685597529; x=1688189529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsI/5WLiHlcp0ZEEt3H/cNP/MuQhNAeZoQaqtMmhWNQ=;
        b=Xk5oBMl6vHPvHH5U1GoyJbjjzq3iXYVGjPwEj7vvnpNar03ETGE0RpPlp2Inz8dpo4
         bBunA8qeoXmoD5UUie60sj9saf/acdjxKbuIaK5ve1hjVoHkFVd+RLx2X1CeCMvIwT/R
         is02vIQRjrTMUzJjAQnJnvJVK1jyHGRJglCLGzvziO1UPPzMvcNVquH3uUP7XEmpBO8e
         7FreYBbofJ+qVZTM/dNYfm2frtcmYmrkPMVqxs/FrJI2FWN9v2zLGRXGv3fqXHOG4Yas
         mmlCAYQFizObN1ScNTtn0KWCs4/53MJIGV5F/iEwyvEN3zD3G0QUv4Y2P+8iIXykWc/D
         Ra0Q==
X-Gm-Message-State: AC+VfDwLmeGXZe7HT2/bn5zVi+hbqRz6lGgrA+w5MS7zq1CIFZ4BH7XQ
        uuHY9gxFibaC4nYOElwOdl1I/EjXjq1yNe49kuCaUA==
X-Google-Smtp-Source: ACHHUZ6jpon6KUyAu7j1RAO8CknM0TiK2EYsevvUBJdlyVaa7KKCWUV7kgxyhKtARKNUKgwtTICTTtzUxsji3KMkuDQ=
X-Received: by 2002:ac2:44dc:0:b0:4f4:ce78:2f17 with SMTP id
 d28-20020ac244dc000000b004f4ce782f17mr582911lfm.13.1685597529125; Wed, 31 May
 2023 22:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20230531191007.13460-1-shyamsaini@linux.microsoft.com> <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
In-Reply-To: <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 1 Jun 2023 08:31:33 +0300
Message-ID: <CAC_iWjKAdimEH0SsC_z9QuFS4sGLp2BVzx03s+RKvcLXY25kuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
To:     "Zhu, Bing" <bing.zhu@intel.com>
Cc:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
        "code@tyhicks.com" <code@tyhicks.com>,
        "Matti.Moell@opensynergy.com" <Matti.Moell@opensynergy.com>,
        "arnd@linaro.org" <arnd@linaro.org>,
        "hmo@opensynergy.com" <hmo@opensynergy.com>,
        "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>,
        "ruchika.gupta@linaro.org" <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Huang, Yang" <yang.huang@intel.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bing

On Thu, 1 Jun 2023 at 04:03, Zhu, Bing <bing.zhu@intel.com> wrote:
>
> As an alternative, Is it possible to change ftpm design not to depend on =
RPMB access at the earlier/boot stage? Because to my understanding, typical=
ly PCRs don't require persistent/NV storage (for example, before RPMB or te=
e-supplicant is ready, use TEE memory instead as temporary storage)

I am not entirely sure this will solve our problem here.  You are
right that we shouldn't depend on the supplicant to extend PCRs. But
what happens if an object is sealed against certain PCR values?  We
are back to the same problem

Thanks
/Ilias
>
> Bing
>
> IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96-4bc=
7-bb2f-442c1b17af26)
> System Software Engineering
> Software and Advanced Technology Group
> Zizhu Science Park, Shanghai, China
>
> -----Original Message-----
> From: Shyam Saini <shyamsaini@linux.microsoft.com>
> Sent: Thursday, June 1, 2023 3:10 AM
> To: alex.bennee@linaro.org
> Cc: code@tyhicks.com; Matti.Moell@opensynergy.com; arnd@linaro.org; Zhu, =
Bing <bing.zhu@intel.com>; hmo@opensynergy.com; ilias.apalodimas@linaro.org=
; joakim.bech@linaro.org; linux-kernel@vger.kernel.org; linux-mmc@vger.kern=
el.org; linux-scsi@vger.kernel.org; maxim.uvarov@linaro.org; ruchika.gupta@=
linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.hansson@linaro.or=
g; Huang, Yang <yang.huang@intel.com>; sumit.garg@linaro.org; jens.wiklande=
r@linaro.org; op-tee@lists.trustedfirmware.org
> Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
>
> Hi Alex,
>
> [ Resending, Sorry for the noise ]
>
> Are you still working on it or planning to resubmit it ?
>
> [1] The current optee tee kernel driver implementation doesn't work when =
IMA is used with optee implemented ftpm.
>
> The ftpm has dependency on tee-supplicant which comes once the user space=
 is up and running and IMA attestation happens at boot time and it requires=
 to extend ftpm PCRs.
>
> But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee c=
an only access RPMB via tee-supplicant(user space). So, there should be a f=
ast path to allow optee os to access the RPMB parititon without waiting for=
 user-space tee supplicant.
>
> To achieve this fast path linux optee driver and mmc driver needs some wo=
rk and finally it will need RPMB driver which you posted.
>
> Please let me know what's your plan on this.
>
> [1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.ht=
ml
>
> Best Regards,
> Shyam
