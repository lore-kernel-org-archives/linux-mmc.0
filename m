Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E94C4332F
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Nov 2022 09:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiKSJvx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 19 Nov 2022 04:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKSJvw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Nov 2022 04:51:52 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A07A0AB0CF;
        Sat, 19 Nov 2022 01:51:51 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id EF2E12A02A4;
        Sat, 19 Nov 2022 10:51:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1668851510;
        bh=3aTTAsXZVhBhUdfEYS3/zAu1/OPOqrK88ARHZlzat0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwtE4rXErE4npVI7FUchHK0WlVYtZuG+l3GbonR+ECi/+Ds16kyj7sGwuGpEM4AP5
         qWQbTlh4dq3dEKOjrSGyeF17WZqA3wmj1hOpgQ3RcRjAlCUzSMatZb38hcfhfYGn7U
         qo9uDEvG29400NT6FQrfqajlhyCcwcdBQ4+VFkVpzttAW0AAuc+F3aLPjErHYdECy9
         p3xV/xvxsKxpBb8zltI9tcEfeXseIQk8SmL8gZvK3oQdZo2O+/n/Mn8nZrSWTHh2Td
         IyDlgCRlcLkSu+39j4+/EJfcuXLJp7owZ3W+cJD6WbXlPg7iSRwHE3Z653ckrtsVT7
         QN+J96P7PrVfg==
Date:   Sat, 19 Nov 2022 10:51:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 1/6] iommu: Add note about struct iommu_fwspec usage
Message-ID: <Y3inNDguBK/OadOH@8bytes.org>
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
 <20221117182720.2290761-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117182720.2290761-2-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 17, 2022 at 07:27:15PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This structure is to be considered private to the IOMMU API. Except for
> very few exceptions, IOMMU consumer drivers should treat this as opaque
> data.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  include/linux/iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)

We should probably hiding the structure outside the IOMMU world then.
But that's another path to go, so

Acked-by: Joerg Roedel <jroedel@suse.de>

