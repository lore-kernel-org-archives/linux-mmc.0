From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Fix cmd error reset failure path
Date: Mon, 13 Mar 2017 14:43:16 +0200
Message-ID: <891eddba-8b7c-3c59-abd3-8933d3fa3aef@intel.com>
References: <558473bd-9fea-6f95-4eb1-9d72b5a25234@intel.com>
 <CACRpkdZMZFpSK7e3OSZFqFYmX1AR9bRq24AFeGY8Udu+XD3wAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15569 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752334AbdCMMsr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:48:47 -0400
In-Reply-To: <CACRpkdZMZFpSK7e3OSZFqFYmX1AR9bRq24AFeGY8Udu+XD3wAw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 27/02/17 16:08, Linus Walleij wrote:
> On Mon, Feb 27, 2017 at 8:36 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Commit 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
>> assumed the request had not completed, but in one case it had. Fix that.
>>
>> Fixes: 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Ouch.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Seems it was applied to the wrong base.  I have sent it again with V2 of the
CQE patches.

