From: Mike Wilson <mikewse@hotmail.com>
Subject: determine erased regions (was: mmc-utils on android)
Date: Mon, 7 Jul 2014 12:05:43 +0200
Message-ID: <DUB128-DS68E8655EA510A2470A328A40D0@phx.gbl>
References: <DUB128-DS1665650474CDB4B62F820DA4030@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dub004-omc1s10.hotmail.com ([157.55.0.209]:55194 "EHLO
	DUB004-OMC1S10.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392AbaGGKF5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jul 2014 06:05:57 -0400
In-Reply-To: <DUB128-DS1665650474CDB4B62F820DA4030@phx.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hoping this might be easy for someone to answer:

Is there a command to determine if a region of blocks in MMC 
storage is erased? Such as getting 0xFF out of a nanddump on 
MTD storage.
I'm thinking I could retrieve data using dd on the MMC device 
and look for the appropriate pattern to see how much of the
storage that has been explicitly erased?

(looking at mmc-utils source it seems it is not what I need)

Thanks
Mike

Mike Wilson wrote:
> I'm trying to recover some data from the eMMC on an Android
> phone (Samsung Galaxy S3). Is there a build of mmc-utils I
> can push to the phone?
> Thanks
> Mike

