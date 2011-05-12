From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: fixed wrong regulator_enable in suspend/resume
Date: Wed, 11 May 2011 23:46:17 -0400
Message-ID: <m3tyd0zily.fsf@pullcord.laptop.org>
References: <4DCA3237.3080609@samsung.com>
	<m3pqnp2vvl.fsf@pullcord.laptop.org> <4DCB4D9B.8050706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37997 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab1ELDn5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 23:43:57 -0400
In-Reply-To: <4DCB4D9B.8050706@samsung.com> (Jaehoon Chung's message of "Thu,
	12 May 2011 12:01:47 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Wed, May 11 2011, Jaehoon Chung wrote:
> Hi Chris..
>
> I think you're confused something because my explanation.
>
> My means..if we use the regulator, regulator is enabled when probing.
> Then regulator is enabling until we don't disable..
>
> In order to power-save, disabled the regulator when entered suspend.
> Already in suspend function, located "regulator_disable()".
> but also located "regulator_enable()" in suspend function.
>
> So i think right that "regulator_enable()" is located in resume function.
> not in suspend function.

Thanks, I agree.  I hadn't looked at the suspend function, but now I see
that it already has the disable.

Will, want to ACK this before I merge it?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
