Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9B9C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 21:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKBVgq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKBVgo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2022 17:36:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF5DFBC;
        Wed,  2 Nov 2022 14:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5546B82524;
        Wed,  2 Nov 2022 21:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632BDC433D6;
        Wed,  2 Nov 2022 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667425001;
        bh=AgleLuoQhQ/T2+EKWum+gAd/7kfW28nzl3E9bNTJERI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=k43EgOmBUxkUzaPARtNPfJ0q5Sk6vZLrcy9sIm5akzu5kPiSvbaMysRJi78BjR4kL
         vULZneLnznVcLUbZT/+zj7oovspo+zGeB8wwBBlqC+9jxpcOxGbzBRCpkGS756OFI2
         nEcaA5ToiHhpPhkAEKxrEGGNbnPVHdQ7TnYI0dKSmV0g7v+6+wacm6hiMZOvR3HLkR
         8kY3IlCUNe3aGP0JJSHZOJtkT8ERn96lLJ9Qd9LMZu7sRcgr2DlejMU9L2zKGmSfZc
         o73OWiyq8TN93/42LXwu+YWxba/gLO33aDHJ3cPWiSikgKAjgYVq2jQf9EtxBK+5Ao
         jR2WK2soZxOiA==
Message-ID: <7e7db667-6321-fad6-16fc-9f2a12c1029e@kernel.org>
Date:   Wed, 2 Nov 2022 17:36:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v11 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, robh+dt@kernle.org, krzk+dz@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com
References: <cover.1667087353.git.tonyhuang.sunplus@gmail.com>
 <61818eada54f5adb873455143cd950b28d57bc2c.1667087353.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <61818eada54f5adb873455143cd950b28d57bc2c.1667087353.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/10/2022 20:50, Tony Huang wrote:
> Add MMC YAML file for Sunplus SP7021.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v5:
>  - Addressed comments from Krzysztof.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Best regards,
Krzysztof

