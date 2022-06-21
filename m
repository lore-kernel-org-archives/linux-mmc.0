Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3656BCCA473
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jun 2022 20:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353995AbiFUU3k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352361AbiFUU3j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2022 16:29:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6E82DA9E
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2022 13:29:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u12so29872278eja.8
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2022 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GQoT4eqYGuax/64sGawgD7sMHV+BWMBDm2reCmNiO4s=;
        b=k+rN15KFxJA6a5zoP03uYyAUUFUaUXZ5WCyn4tsLzy3Z8nbqPA2uh+MFWG/ejpgZdt
         fAMPct0hVTpOk6dY1CtpVoGS48IY07+4qGc6mvZImuCQ0HO8tDZ6Dj7IFv61OUAkNmIe
         l8zutKN4eY/nZlDqTNhTr40wnq8/5PJ8i2x9UmdBmbR302lLpiTRyluuUeR/BL+pIDEN
         ZyUjQeFqRNI55hVDY6vkbqrv4tUJPgVaQYtNdLwudlwwSYOfjNKRGpN3xf8KAcxXw0VG
         Q6R82oOsuoNaALct3Wm1rVZxIYfPGRrF9gpYMV3LjU99VTUg0yc1+F0sYzxtMJU83xCY
         ySkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GQoT4eqYGuax/64sGawgD7sMHV+BWMBDm2reCmNiO4s=;
        b=lKsFXxwaQdeXaIBQCx1pDQRQMDI6h3E9TLcNXXWIvhcirBOrs3nKdJTW0a5IvtZUlW
         zA8qB0yr2+V31u06ruznFSM+91e3RGaigHeBb662YRVq5dY49+5ZOIp12wQI7KxXLiAp
         pt98seCIf97Dq3hnihQQAKKAfqfv72dJ0zUzf0ii6qn0+2jHEuxPiwLHcYksTZRt8cAc
         moYNM6FziLu4nXzMZUzrQDN0X1c27GOKj5YQzYGU/XUEbT2G6P/ufTCmAldeSV+wg+uo
         pZfkuWGFB5lf4UgmJjtiU5NkMMA3AtLgGur2yfBtMCEeKxV4vXufjM0RtXnddavyJW73
         pE3w==
X-Gm-Message-State: AJIora9h9XeX2k444VnjLakjle+qBuncOt7Adsz8UlrzaZa5oAieavpK
        9IDsPOYdDkVZ6H4petnTcWppSEFKVY28b9PPdGzdyw==
X-Google-Smtp-Source: AGRyM1v2V9388Qkgg2T6Sj1QZIN2f5LmKlNSpQwA0h9/cgUy9z29R5wk/xhzbEPKrmXmDL6wGIYNKGmqGyASlMZNlXY=
X-Received: by 2002:a17:906:c193:b0:718:d076:df7 with SMTP id
 g19-20020a170906c19300b00718d0760df7mr28234264ejz.358.1655843375835; Tue, 21
 Jun 2022 13:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220621085345.603820-1-davidgow@google.com> <20220621085345.603820-3-davidgow@google.com>
In-Reply-To: <20220621085345.603820-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 21 Jun 2022 13:29:24 -0700
Message-ID: <CAGS_qxqnCvTnE-cGd-LNnhCMsz5YE3Ea9jw_OqNDwjQQ9TGpGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>, Paraschiv@google.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 21, 2022 at 1:54 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: Daniel Latypov <dlatypov@google.com>
>
> We currently store kunit suites in the .kunit_test_suites ELF section as
> a `struct kunit_suite***` (modulo some `const`s).
> For every test file, we store a struct kunit_suite** NULL-terminated arra=
y.
>
> This adds quite a bit of complexity to the test filtering code in the
> executor.
>
> Instead, let's just make the .kunit_test_suites section contain a single
> giant array of struct kunit_suite pointers, which can then be directly
> manipulated. This array is not NULL-terminated, and so none of the test
> filtering code needs to NULL-terminate anything.
>
> Tested-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220618090310.1174932-3-davidgow=
@google.com/
> - No longer NULL-terminate generated suite_sets

Nice!
Thanks for picking and cleaning this up!

Daniel
