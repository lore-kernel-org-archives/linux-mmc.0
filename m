From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Fri, 28 Oct 2011 16:42:46 +0200
Message-ID: <CAAgDR1Ndk_oC1T_7e8CrW7K2vHFLgFsL9PoXWn-0dypmT1cZRg@mail.gmail.com>
References: <4EA93C08.9030009@samsung.com>
	<loom.20111027T202726-264@post.gmane.org>
	<CAAgDR1PJFX1c3xexgv7=Ccm3HGRtu0VMDy6APWUExSHOO3aE4A@mail.gmail.com>
	<4EAA8B7E.1040203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59179 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab1J1Omr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2011 10:42:47 -0400
Received: by ggnb1 with SMTP id b1so3728326ggn.19
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2011 07:42:46 -0700 (PDT)
In-Reply-To: <4EAA8B7E.1040203@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Per Forlin <per.lkml@gmail.com>, linux-mmc@vger.kernel.org

> Maybe i think that my-patch should be worked only level-2/3..right?
> Because URGENT_BKOPS bit in the EXCEPTION_EVENTS_STATUS is set whenever is either 2 or 3.
> In this case, host control with R1-type response.

For 4.41 your patch is fine. For 4.5 I think it starts BKOPS too often.

For 4.5 devices the R1 response indicates that there is an exception
event which may be have several different causes: PACKED_FAILURE,
SYSPOOL_EXHAUSTED, DYNCAP_NEEDED or URGENT_BKOPS. But if the R1
response indicates an exception event it may be becuase of a cause
which is not URGENT_BKOPS. So for 4.5 you must read
EXCEPTION_EVENTS_STATUS to determine what the cause was.

> But in level-0/1 case, need to check BKOPS_STATUS periodically.
> How did you understand that "periodically" means?
> If host need to get BKOPS_STATUS periodically, maybe send CMD8 periodically.
> How periodically?

Good question, I don't know yet. Problem this should be done when the
system is otherwise idling, to not interfere with normal accesses (if
you do I would expect you to get worse performance).

 / Sebastian
