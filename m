Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19433C43217
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E7961074
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 10:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhIQKSD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 06:18:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:56384 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242104AbhIQKSC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Sep 2021 06:18:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="209998947"
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="209998947"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 03:16:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="472208475"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 03:16:33 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 17 Sep 2021 13:16:30 +0300
Date:   Fri, 17 Sep 2021 13:16:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v1 4/6] thunderbolt: build kunit tests without structleak
 plugin
Message-ID: <YURq/qq32WnOaJag@lahna>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-5-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917061104.2680133-5-brendanhiggins@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 16, 2021 at 11:11:02PM -0700, Brendan Higgins wrote:
> The structleak plugin causes the stack frame size to grow immensely when
> used with KUnit:
> 
> drivers/thunderbolt/test.c:1529:1: error: the frame size of 1176 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Turn it off in this file.
> 
> Linus already split up tests in this file, so this change *should* be
> redundant now.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
