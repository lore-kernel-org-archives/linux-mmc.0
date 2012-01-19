From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 02/12] dmaengine: Add flow controller information to dma_slave_config
Date: Thu, 19 Jan 2012 17:59:54 +0100
Message-ID: <CACRpkda6-rzCOZkMuagAAxof0FVJMzExnP-QUHtztKM44v=eTw@mail.gmail.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
	<5f9ec59562e86536c4123f61891b95590293030f.1326876464.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63746 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab2ASQ7z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 11:59:55 -0500
In-Reply-To: <5f9ec59562e86536c4123f61891b95590293030f.1326876464.git.viresh.kumar@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, cjb@laptop.org, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, egtvedt@samfundet.no, hskinnemoen@gmail.com, kernel@pengutronix.de, perex@perex.cz, linux-arm-kernel@lists.infradead.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

On Wed, Jan 18, 2012 at 10:11 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Flow controller is programmable for few controllers and there are few
> intelligent peripherals like, Synopsys JPEG controller, that needs to be a flow
> controller of DMA transfers on dest side.
>
> For this, currently two drivers, pl08x and dw_dmac, support flow controller to
> be passed from platform to these drivers.
>
> Perhaps, this should be a part of struct dma_slave_config. This patch adds
> another field device_fc to this structure. User drivers must pass this as true
> if they want to be flow controller of certain transfers.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Viresh,
Linus Walleij
