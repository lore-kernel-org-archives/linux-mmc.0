From: "Lee Susman" <lsusman@codeaurora.org>
Subject: (unknown)
Date: Wed, 8 Aug 2012 23:55:10 -0700 (PDT)
Message-ID: <730b7f12309112022731f13920cb2f6d.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:38446 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab2HIGzK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Aug 2012 02:55:10 -0400
Subject: 
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: axboe@kernel.dk, linux-mmc@vger.kernel.org
Cc: tlinder@codeaurora.org

Hello all,

I ran into some difficulty with Btreplay, maybe you could help me:
I am trying to emulate async write requests using Btreplay, but it seems
that Btreplay submits only sync writes.
I could not find any reference in the code as to manipulating this option.

I would appreciate your help.

Thanks,
-- 
Lee Susman,
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

