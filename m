Return-Path: <SRS0=X1IY=6X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454EBC54E4A
	for <linux-mmc@archiver.kernel.org>; Sat,  9 May 2020 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFFF24958
	for <linux-mmc@archiver.kernel.org>; Sat,  9 May 2020 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589027458;
	bh=0pINHCe149/hIGfHpl78LOiYhlqOZDIOygvNmvlot4E=;
	h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=cwm8ZaGLojtOxsTUAuTKo9RzQUDw4Oo+emKdzzvaYgRPdwqqwnSewxyfgugAMfOiU
	 fyhkKdNen9Yg4P7/1RmXnQEYrolCUDi79tmf6cREsUuHYZIsuyFWujA8j4d6nRZg1u
	 SZmYbZYB287qVnTS91SoZaIpeyti1C9mFmUH35cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgEIMa4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 9 May 2020 08:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgEIMaz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 9 May 2020 08:30:55 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C7E724956;
        Sat,  9 May 2020 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589027454;
        bh=0pINHCe149/hIGfHpl78LOiYhlqOZDIOygvNmvlot4E=;
        h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
         From;
        b=gpo1x5ID3Yx6RBtuEwYTVyiqWXm6zUv8S/DIZ4GI9F+shHkz+BgZUcFHDFOIPHOFO
         Jf/P3L1EGU6nK04xuPAYt/yPeVnTmiT7O2gHx9uXLY8lyWtUiusKLew2eJJaMw/dJc
         3A/uPLa7i6iBgeQI/qBKBZlTjP8Yz1Glep3YRn2k=
Date:   Sat, 09 May 2020 12:30:53 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     stummala@codeaurora.org, linux-mmc@vger.kernel.org
Cc:     <stable@vger.kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH V2] mmc: core: Fix recursive locking issue in CQE recovery path
In-Reply-To: <1588868135-31783-1-git-send-email-vbadigan@codeaurora.org>
References: <1588868135-31783-1-git-send-email-vbadigan@codeaurora.org>
Message-Id: <20200509123054.9C7E724956@mail.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 1e8e55b67030 ("mmc: block: Add CQE support").

The bot has tested the following trees: v5.6.11, v5.4.39, v4.19.121.

v5.6.11: Failed to apply! Possible dependencies:
    511ce378e16f ("mmc: Add MMC host software queue support")

v5.4.39: Failed to apply! Possible dependencies:
    511ce378e16f ("mmc: Add MMC host software queue support")

v4.19.121: Failed to apply! Possible dependencies:
    310df020cdd7 ("mmc: stop abusing the request queue_lock pointer")
    511ce378e16f ("mmc: Add MMC host software queue support")
    b061b326287d ("mmc: simplify queue initialization")
    f5d72c5c55bc ("mmc: stop abusing the request queue_lock pointer")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
