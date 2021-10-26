Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB5C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 00:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3FC60F70
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 00:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhJZAzd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Oct 2021 20:55:33 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:54163 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233234AbhJZAzd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Oct 2021 20:55:33 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id DA120580728;
        Mon, 25 Oct 2021 20:53:09 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Mon, 25 Oct 2021 20:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=V0T2kJy73U3uAaMJMaKuV6KJcyjcpfP
        oCYCDulI/FAk=; b=Z+qVG2iAadM4MbCKcUhZK7A9dVqRKHJZCXjtaFwZL4NvG5f
        u20dU4z/aLL5RjL3fdlQiuSBkcG+rZGjUXivmWgc6GpROX5oH2PVoG8gyxM3tCPV
        +zgaopnS4rp1aiF2LalCIKk9pwYQlQNTcw+fvmDybIP+HIjXwqksMc4TlHyAfffS
        Bg+yozqnUVRkucLZof7Z0zz24m2eC7O3KrYIWc5iGu+qPEanIpPRygxF0+Q0Vtnt
        dyI2ya3eFjK+yqiQH34gWcras6Bvmnw4LdwfKY2Jh6VYhw5CVLZM03QKODpoPL8r
        FFW1ie7T6BUw0bD63ONK322g4lYhVEPOy5tf1gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V0T2kJ
        y73U3uAaMJMaKuV6KJcyjcpfPoCYCDulI/FAk=; b=WBSJ4GRJxNzEuiKowL0A82
        QgmhMIGDAIr9TCG/RR6qYka0JtQjHIJtbp506aw61Ivg8x1wSHhzWgH0IRJWoIB9
        3PyMvWAmvUx8x9+Vs1kPGetb/4LCi9EJUmmMTVWxTqzI+kTU9+e7sXXagYuGo4Ez
        XgMu0F31LmPRUylRYcwEMqLy4f/8Pvca1N5aYNTdbv5HaR5LqaehzoTurUpSpEzn
        GrELCwJuMyxD+dWeyBcCX/QEZfqyWzrN4JdRzW8WSbJLhW/PHoPBc8OT3yx797Hv
        Q2t3/90E6O1u8XsqfDMmpVOdojDLql9kZL2ckGR4e8DyrMpGGFokEBOsaE7tLjWA
        ==
X-ME-Sender: <xms:dVF3YbisDWbGSHxF9z8xdApzqt_B9j05JClaC5yX_0uszojqul4Wqw>
    <xme:dVF3YYD2lc4fBU-RNRpYkq1DpkaEOdemdfpLPpMjWb9idZ5d7Kayef9CHjb0JPGvB
    vul_12VkGdwK2OUOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefiedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepudfftddvveekfffgteffffeuveegjeelgefhffejtdehtdfhlefgkeef
    hfefkeeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:dVF3YbFMseYAinOGxo5AcNdSXiQmQlWiToSO5I1Fema7QxPdwZQZ1Q>
    <xmx:dVF3YYQZdPr9pe6ZXIKVvFzNGTBUyKlknofeKk4qqXG-mrxSMKv9Dw>
    <xmx:dVF3YYw5TyzcXVz1SVKjtNySWBbNcWClqg6N25styc5hty8uTP8htQ>
    <xmx:dVF3YTpOp9l8IpeBaBvI0RXlFBDBxiWKBOf4g8moiS-RPkglrTNAhg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 30210AC03DB; Mon, 25 Oct 2021 20:53:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <5a235916-f250-48ac-b931-6ec2c5c2ea5d@www.fastmail.com>
In-Reply-To: <20210922103116.30652-5-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-5-chin-ting_kuo@aspeedtech.com>
Date:   Tue, 26 Oct 2021 11:22:49 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, "Steven Lee" <steven_lee@aspeedtech.com>
Subject: Re: [PATCH 04/10] mmc: Add invert flag for clock phase signedness
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Sep 2021, at 20:01, Chin-Ting Kuo wrote:
> The clock phase degree may be between -360 to 360.
> If the data signal is leading to the clock, the signedness
> of clock phase is postive, otherwise, the signedness
> is negative.
>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

The implementation here can't be changed without a change to the 
binding documentation:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/mmc-controller.yaml?h=v5.15-rc7#n345

> ---
>  drivers/mmc/core/host.c  | 10 ++++++----
>  include/linux/mmc/host.h |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index d4683b1d263f..c2de7cbc7838 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -214,14 +214,16 @@ static void mmc_retune_timer(struct timer_list *t)
>  static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
>  				      struct mmc_clk_phase *phase)
>  {
> -	int degrees[2] = {0};
> +	int degrees[4] = {0};
>  	int rc;
> 
> -	rc = device_property_read_u32_array(dev, prop, degrees, 2);
> +	rc = device_property_read_u32_array(dev, prop, degrees, 4);
>  	phase->valid = !rc;
>  	if (phase->valid) {
> -		phase->in_deg = degrees[0];
> -		phase->out_deg = degrees[1];
> +		phase->inv_in_deg = degrees[0] ? true : false;
> +		phase->in_deg = degrees[1];
> +		phase->inv_out_deg = degrees[2] ? true : false;
> +		phase->out_deg = degrees[3];

This fundamentally breaks any in-tree users. We can't do this.

In terms of the binding, if negative phase values are something we must 
do, we can just extend the value range to include [-359, -1] right? 
That avoids changing the type of the value positions in the manner this 
patch does.

Andrew
