From: wwang <wei_wang@realsil.com.cn>
Subject: Re: [PATCH v7 0/3] Add modules to support realtek PCIE card reader
Date: Tue, 30 Oct 2012 11:33:28 +0800
Message-ID: <508F4A88.8010207@realsil.com.cn>
References: <cover.1351481260.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:60142 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab2J3DeP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 23:34:15 -0400
In-Reply-To: <cover.1351481260.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?GB2312?B?zfXsvw==?= <wei_wang@realsil.com.cn>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "oakad@yahoo.com" <oakad@yahoo.com>, "bp@alien8.de" <bp@alien8.de>

Hi Chris, Samuel and Alex:

Can you help to review this patchset, please?

I have asked Greg to remove rts_pstor from the staging tree. So this
driver have to be merged into 3.8 kernel, or else Realtek'sPCI-E card
reader can not be accessed easily.

BR,
Wei WANG

