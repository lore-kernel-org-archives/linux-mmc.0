Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC49C001B0
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGMLoW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjGMLoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:44:21 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F59DB4;
        Thu, 13 Jul 2023 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689248661;
  x=1720784661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cFO3l+192XuHkKdmF6g/YsB/oo8Dl96YRq1cZM+PIvc=;
  b=YOpXYMgfDc96CkLhdJbYhLmt2Qp3A8xzl54wwssaLEGNpiguvLEKQrof
   0E+hqgpweJVkQlAYZu4KyHs/9luTEbNT6K6Fc0oDwKPprHNUEsO6l+FwP
   kw4DpZ9Pb2YTP5Nv8Tc5qJJYwhzy6ljFXS9NaV6TAB2a323E+fuiZSfOx
   fw7nTcE0PCNOwUJpOATCKFC/ebvrpLtAY35Wm1y6bDNU5ozYQxqv09bM9
   lKv1QHyhhwFuQ4PkGJZRnCgPJMBcuam0tpjG9aTIR5PIuZMI+PddS3xbi
   B6x+yktxo26C0qtvtnNzTH8UjAi7p0r1+wRTmt1stKrWASCtbqZruBUCL
   g==;
Date:   Thu, 13 Jul 2023 13:44:18 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Yangtao Li <frank.li@vivo.com>
CC:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-arm-kernel@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 45/58] mmc: usdhi60rol0: Convert to platform remove
 callback returning void
Message-ID: <20230713114418.GC13100@axis.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-45-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713080807.69999-45-frank.li@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 13, 2023 at 04:07:54PM +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
