Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F6FC43334
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jul 2022 18:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiGHSXh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbiGHSXX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2022 14:23:23 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA7188F27
        for <linux-mmc@vger.kernel.org>; Fri,  8 Jul 2022 11:23:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 190so4341598iou.6
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jul 2022 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97VK5iQW+OLAMctb3bRhnVJI2Dk4NFeFeJbQXMmdP9g=;
        b=dm7gPCV+4gyiVAxSxrFBQejGH77CCYpAJBElNtgCngEA5WBI7Yc2n3yywfIFlpcCQd
         78g5turygqj6DdxWi3846rwYQBQlX8o9NVT3W8VVAhJUOgBlNd71vpPAVU7MkPRWnoyV
         mxwci8zjQG/h2zn69Vyv0HFfD7p0oOaFdBVmG/CeXp4vKGkaOR8ntd+QkwJKIvtSKtA3
         iDWXSAT7vQ0X1EGvbKQyqsp55ZEhSbF8lpjPQDRJ7aqB5JL0JpaM/9HcziOkPjuENTsi
         +vuwgM7BUKnDpoiNFCqHK6QcJ8qeVKH6wEXSEvf67S6wPwYcKKbL7mxAZlb01woQqmE6
         XTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97VK5iQW+OLAMctb3bRhnVJI2Dk4NFeFeJbQXMmdP9g=;
        b=ar5JqxR5eRV48Q78zcqRsq4GRTcwy7BicmkKdMhJBPuvRNKtRpEOZS2vtl+YwW/eJ7
         fY+oxd/HsTJP3DZyly2rMaJrelBCQRb2hSxg8ly87fjxTVNttVWGWSSEaoapU5Qg0233
         ths/+DI8N9GM0BgnZALxtjy813/dt4SpfEb8d8WPtDAsc+eh8c0nTRj7I69eLAwxM/HG
         82X5ruJ+MojfNkz0yhHCiDvNi6fFqa9WgaM+g1Pt3QgLz+QLXU9NNn8fI5Znzb8JzYtx
         /HMw7qpYJdfml6c+trhOnYA9D05SZSyAiIkwoKKRaP6kY+rqcExlnnFypJGiZRfcd8Su
         n8ow==
X-Gm-Message-State: AJIora+Z6ysQLSfzTAGq9+MGFY4q07HqPAvGdYVw5gWjTZKO8ly505C9
        lA5TfXiCxDoO7wtlRxZMnLeaJvhOsRSAiWs+PmZ3Sw==
X-Google-Smtp-Source: AGRyM1v951IbthTm0LElBbaQF/7RITAtzDe990vOEfJILkJ06LZs6GkFPaKHhzsiSy2JTGmWeVbLwI83+m4nwKm1Q7M=
X-Received: by 2002:a02:a105:0:b0:33f:1909:6c82 with SMTP id
 f5-20020a02a105000000b0033f19096c82mr2997602jag.278.1657304599260; Fri, 08
 Jul 2022 11:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-2-davidgow@google.com>
In-Reply-To: <20220625050838.1618469-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 8 Jul 2022 11:23:08 -0700
Message-ID: <CAGS_qxrGwVL37AOUWCxwx=qg6YvXCDSSu4p_PSt7_87N3RxJZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] kunit: unify module and builtin suite definitions
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jun 24, 2022 at 10:10 PM David Gow <davidgow@google.com> wrote:
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8ffcd7de9607..54306271cfbf 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -250,41 +250,8 @@ static inline int kunit_run_all_tests(void)
>  }
>  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
>
> -#ifdef MODULE
> -/**
> - * kunit_test_suites_for_module() - used to register one or more
> - *                      &struct kunit_suite with KUnit.
> - *
> - * @__suites: a statically allocated list of &struct kunit_suite.
> - *
> - * Registers @__suites with the test framework. See &struct kunit_suite for
> - * more information.
> - *
> - * If a test suite is built-in, module_init() gets translated into
> - * an initcall which we don't want as the idea is that for builtins
> - * the executor will manage execution.  So ensure we do not define
> - * module_{init|exit} functions for the builtin case when registering
> - * suites via kunit_test_suites() below.
> - */
> -#define kunit_test_suites_for_module(__suites)                         \

Deleting this bit now causes merge conflicts with Shuah's kunit
branch, due to https://patchwork.kernel.org/project/linux-kselftest/patch/20220702040959.3232874-3-davidgow@google.com/
I.e. We added in a MODULE_INFO(test, "Y") in this to-be-deleted section.

Perhaps something like this would be a fix?

  #ifdef MODULE
  #define _kunit_mark_test_module MODULE_INFO(test, "Y")
  #else
  #define _kunit_mark_test_module
  #endif /* MODULE */

  #define __kunit_test_suites(unique_array, unique_suites, ...)
          \
          _kunit_mark_test_module;
          \
          static struct kunit_suite *unique_array[] = { __VA_ARGS__,
NULL };     \
          static struct kunit_suite **unique_suites
          \
          __used __section(".kunit_test_suites") = unique_array


> -       static int __init kunit_test_suites_init(void)                  \
> -       {                                                               \
> -               return __kunit_test_suites_init(__suites);              \
> -       }                                                               \
> -       module_init(kunit_test_suites_init);                            \
> -                                                                       \
> -       static void __exit kunit_test_suites_exit(void)                 \
> -       {                                                               \
> -               return __kunit_test_suites_exit(__suites);              \
> -       }                                                               \
> -       module_exit(kunit_test_suites_exit)
> -#else
> -#define kunit_test_suites_for_module(__suites)
> -#endif /* MODULE */
> -
>  #define __kunit_test_suites(unique_array, unique_suites, ...)                 \
>         static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
> -       kunit_test_suites_for_module(unique_array);                            \
>         static struct kunit_suite **unique_suites                              \
>         __used __section(".kunit_test_suites") = unique_array
>
