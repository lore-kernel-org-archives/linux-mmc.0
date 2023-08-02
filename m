Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8BAC41513
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Aug 2023 08:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjHBIcU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHBIcT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Aug 2023 04:32:19 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B41718;
        Wed,  2 Aug 2023 01:32:17 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6CE97320076F;
        Wed,  2 Aug 2023 04:32:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 04:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690965134; x=1691051534; bh=GB
        G2iKqO5PLeYvfwEjwF9EfXGrregHJ1kfLxVcxwYlQ=; b=N3cPseisV9cVkV9zmd
        +Bj0c3T/Wrqvr8HGhu48TPsFZYMroG0x1spK0Q6jRZaNc9snoFo+RkPuA/AgW9Bh
        fOwYlNsmXg3nnpQRNWK7q8ABt1Lzgw+qMDxOA+CxZWfMFJvyOuHAk0OM1h8myV4i
        7Xin9sSc4Il3SjgmNH7ALnR/lF4AUNbz3h8qGTrbcqS2M/QSkkzTPYJUBvGKM5zn
        2hu4ZJlftWIr3+jEESpF15ZfcVU9T+CCczsa2l6H4TdW1xgstwKKwh+KhNS3+3K8
        o+1T81F2DGqQj48bgi5LR5AfNwPOpIy4fFAfc4TsC+mNJYThYt8Zw+aWJrJraY3H
        Us7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690965134; x=1691051534; bh=GBG2iKqO5PLeY
        vfwEjwF9EfXGrregHJ1kfLxVcxwYlQ=; b=jwgUEuAhEP3PhPlh0SzuL7yYo4p3Y
        CCt6YczgNZOBt7AUJjrI+azaYJpjYNktLqYTftnnXtQsCAF6nlNq+m5aFLGEPSa8
        qnAaEYgn+UTwoFcLZs3EuN7S4BhyBFjNs2eyN1HgvhHxliD760QqPtFRRUrmKNT4
        e6UF1oPJmY2+eSQYoxHe3VreWcsQgv4iovxZpXhHhpoHoVTOccCgdcRSVNl0h30D
        ZXmJqFXABqDiH3+VPUT25g6id0ORnjoZSMvzv9lHdKkvfvkjSudeYnC03S3V/gZt
        jVRlfpfTNbOReO+IM7lVabZfAnIOUAv4G416kO3+ulLgN/bQMxeGGxexg==
X-ME-Sender: <xms:jhTKZNGkWeckBUSDcHpvvaww6e8jBe8feKb-Va2PpKIVLISBMHAVaA>
    <xme:jhTKZCUP4YE1W2XwGA5s_ScLBnflpk9xQUxNO_ayDj-wa_RW-xdEBmxxVCg0aZ3Js
    1UGB6vZlkxu6y8or2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeekgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jhTKZPII64Og5KUBH2mOQtXiTk5Pc6AyBlljraY3voghYifE5WV9xw>
    <xmx:jhTKZDGnF7V2k4i28YgZ9G3aJc-4GxW7jzEGLErvHLJce-t2WS2L3A>
    <xmx:jhTKZDX6tzb2XofG_Rp_t2u-b7cajc7LQVvYeX4wUINUxv41nP8oUA>
    <xmx:jhTKZEvACZccrO8b7T7ax00lBYJ9lp-6kR4UZmBCS6COn6IMgOObQQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 55E9AB6008D; Wed,  2 Aug 2023 04:32:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <599b845c-80d9-467c-b9ac-2ce844ee256e@app.fastmail.com>
In-Reply-To: <20230801173544.1929519-3-hch@lst.de>
References: <20230801173544.1929519-1-hch@lst.de>
 <20230801173544.1929519-3-hch@lst.de>
Date:   Wed, 02 Aug 2023 10:31:54 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christoph Hellwig" <hch@lst.de>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Manuel Lauss" <manuel.lauss@gmail.com>,
        "Yangbo Lu" <yangbo.lu@nxp.com>, "Joshua Kinard" <kumba@gentoo.org>
Cc:     "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        "open list" <linux-kernel@vger.kernel.org>,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-rtc@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/5] mmc: au1xmmc: force non-modular build and remove symbol_get
 usage
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 1, 2023, at 19:35, Christoph Hellwig wrote:
> au1xmmc is split somewhat awkwardly into the main mmc subsystem driver,
> and callbacks in platform_data that sit under arch/mips/ and are
> always built in.  The latter than call mmc_detect_change through
> symbol_get.  Remove the use of symbol_get by requiring the driver
> to be built in.  In the future the interrupt handlers for card
> insert/eject detection should probably be moved into the main driver,
> and which point it can be built modular again.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Good idea.

>  	  of Alcor Micro PCI-E card reader
> 
>  config MMC_AU1X
> -	tristate "Alchemy AU1XX0 MMC Card Interface support"
> +	bool "Alchemy AU1XX0 MMC Card Interface support"
>  	depends on MIPS_ALCHEMY
>  	help

This needs a 

      depends on MMC=y

otherwise you get a link failure with CONFIG_MMC=m and
CONFIG_MMC_AU1X=y.

With that fixed,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
