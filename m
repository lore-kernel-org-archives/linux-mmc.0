From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (mmc-next) 2/3] mmc: split the sdhci.h to help platforms
 that uses shdci-pltfm d.d.
Date: Mon, 27 Sep 2010 16:20:51 +0200
Message-ID: <4CA0A843.8090309@st.com>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
 <20100927104320.GD2664@pengutronix.de> <4CA094CE.2010904@st.com>
 <20100927141304.GH2664@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:55085 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752614Ab0I0OVJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Sep 2010 10:21:09 -0400
In-Reply-To: <20100927141304.GH2664@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 09/27/2010 04:13 PM, Wolfram Sang wrote:
> On Mon, Sep 27, 2010 at 02:57:50PM +0200, Peppe CAVALLARO wrote:
> OK for the host-struct. What about the io-accessors? Do we really need
> them?

Hi Wolfram.

Hmm, it's not necessary to move them, indeed.
They can stay in the original header if you prefer.
No issues on my side at all.
Let me know so I'll rework the patch and send it again.

Regards,
Peppe
