Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFAEC61DA4
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 19:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBNT5T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjBNT5M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 14:57:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22E12C647
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 11:57:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C209B81E2A
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 19:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA06CC433D2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676404625;
        bh=CPylZ0qftEg4UOI8sU+jcUS8eqcxqFiPBjML5NQEL0s=;
        h=Date:From:To:Subject:From;
        b=d6R46kn6a4E+98hot3wqpfA1iCN5CbxS4JBQXnrLc5JL44fHpPZ/Kvqyuf64Z5W02
         Pb3w0N1FVHvF+CxLD4pM7n60muXZT3jS16WTlKvnq54cGuAgP3BlDptUE1JJAEGOjc
         rGpsDvWY9wts7Zvu7XcE4Sn4+K86NO2wTBde18W/V5wXxgMj61CJyZA+616VoWdeh7
         IRpmDdoUPleN1jDpnh7wK67QZhxfJqYTYJIV+KvIqjAilCIXpSD/WZj6qJYPs3j2HQ
         VBSEOtU/21HoaKcgqw4GSaMog95ai78WJljAa5OWK8JfDqydRzkFmtmz2+EEFlFO59
         dxBT5gLt5gjzw==
Received: by pali.im (Postfix)
        id 331BD621; Tue, 14 Feb 2023 20:57:02 +0100 (CET)
Date:   Tue, 14 Feb 2023 20:57:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-mmc@vger.kernel.org
Subject: Announce: sdioutils (lssdio & sdioids)
Message-ID: <20230214195702.ungo5roxliq7pjas@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello! I would like to inform about new (or rather old) sdioutils
project, which is on github: https://github.com/sdioutils/

It aimed to be collection of SDIO programs for Linux systems.

Currently it contains two things which can be useful for both users and
developers:

* lssdio - https://github.com/sdioutils/lssdio - tool which prints all
  connected and registered SDIO devices in similar format than lspci or
  lsusb, including tree and verbose formats (Linux v5.10+ required for
  printing all information)

* sdioids - https://github.com/sdioutils/sdioids - database file
  sdio.ids of known SDIO devices, in format inspired by pci.ids and
  which is already used by lssdio

This new sdioids contains updated and imported database file from the
old udev project (which seems to not be updated anymore).

If you look into the repository, both parts are more than year old and
I did not announced it before because more people promised to test or
improve database... but nothing happened, only promises. So I decided to
announce it now at least in this state. I think that it can be useful
even in the current state.

So if you want to improve it or add new SDIO cards into database, feel
free to open a pull request on project page. I think that having some
central point of sdio.ids database can be useful also for other
projects.
