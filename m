From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] goldfish: emulated MMC device
Date: Tue, 22 Jan 2013 22:47:01 +0000
Message-ID: <20130122224701.5785e345@bob.linux.org.uk>
References: <20130121234339.19859.80987.stgit@bob.linux.org.uk>
	<CAGxe1ZGu4mQRPy=17-G2pBqVOTgwHs4pAsJZ8Bb2V+HNiiq2JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34378 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab3AVW0g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Jan 2013 17:26:36 -0500
In-Reply-To: <CAGxe1ZGu4mQRPy=17-G2pBqVOTgwHs4pAsJZ8Bb2V+HNiiq2JA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org

> does it support dt? i cannot see and table entry here? I think Nall ew
> drivers added should be dt compatible.
> there should be a of table entry here

The Goldfish virtual platform doesn't use devicetree, it does its own
magic. That's out of my control. If you care then open discussions with
google about future versions of the Android Virtual Device.

Basically it has an IPC based discussion with the emulator which tells
it directly what devices to create.

Goldfish is an established platform used for most Android development
work nowdays so we don't get to re-decide how it works just support it.

Alan
