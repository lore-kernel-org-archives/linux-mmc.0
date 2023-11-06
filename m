Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C60C4167D
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Nov 2023 14:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjKFOXk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Nov 2023 09:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjKFOXj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2023 09:23:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2713FDF
        for <linux-mmc@vger.kernel.org>; Mon,  6 Nov 2023 06:23:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861F7C43395;
        Mon,  6 Nov 2023 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699280616;
        bh=w7dHNHjVy1TLGhtSBU8lxIvvnDGwwAXNk5o9pZ5Er9k=;
        h=Date:From:To:Subject:From;
        b=y718qBrRvpAFGy67Shy8zZqWBGFXEokB/Od9iKKgk0H2OLfHB5AALN3hZp8zdD9wW
         ixNL3OxGLbiBsSRUEKgM+XdsyPSLvjLFGtWnVE36tMxK3jE9LLBGLe3v1mPDYRAPMo
         64uUQSvvEOaz43MxSR9LktzQSLVlD71di5fVZOw0=
Date:   Mon, 6 Nov 2023 09:23:35 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-mmc@vger.kernel.org
Subject: PSA: migrating linux-mmc to new vger infrastructure
Message-ID: <20231106-tricky-dachshund-of-fame-7a9414@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Good day!

I plan to migrate the linux-mmc@vger.kernel.org list to the new infrastructure
this week. We're still doing it list-by-list to make sure that we don't run
into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
