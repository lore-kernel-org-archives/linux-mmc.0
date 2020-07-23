Return-Path: <SRS0=muGE=BC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C574C433E4
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jul 2020 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ACE22BF5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jul 2020 08:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595492905;
	bh=u/5FCrRTDKTtlbizSg/fIdLBcnQ5OWN7nudO9AHOx60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WiNf0sOpD/1X7dZ/zCrVAl5tPwhQYYUp8UFTqKMV01T78bcA8roNBmR6Tjy6RVzZv
	 hvT5jyuJVpE2X/+mafODkOC17S7FQvr397+K8qco9fmNwOszUHN0DrulvqG2dQKi00
	 t74JdtUw3ToppKII11R7DCksRQUU6OunnE2qwOeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGWI2X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgGWI2W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Jul 2020 04:28:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9AC20888;
        Thu, 23 Jul 2020 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595492902;
        bh=u/5FCrRTDKTtlbizSg/fIdLBcnQ5OWN7nudO9AHOx60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wnE/+C+ziXsxwj9qX0nKny24nw6Fg35PyNT4yNrm9yuODoR50mHDyTNVza46fTKHM
         JyLIn1i3ubTCzlT2wl9djNCuk749KV9L9zCe7bBNrjTAxgXoRCdPXVNldy+YfK34T3
         t6DnbJuutVjlGnpdhJV5gcFF6yqpCwtA8hD4oUNk=
Date:   Thu, 23 Jul 2020 10:28:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rui Feng <rui_feng@realsil.com.cn>, Klaus Doth <kdlnx@doth.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/5] minor rtsx cleanups
Message-ID: <20200723082825.GA1517138@kroah.com>
References: <20200721212336.1159079-1-helgaas@kernel.org>
 <CAK8P3a0aqus-7Z-qSc9J+gOsSCX5Ad570F-3a_HB1MHfJor7Bg@mail.gmail.com>
 <9f42cc48087a447a8ff295a86d439039@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f42cc48087a447a8ff295a86d439039@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 23, 2020 at 08:16:10AM +0000, 吳昊澄 Ricky wrote:
> Hi Arnd, Bjorn,
> 
> So How can I do for now?
> I need to wait Bjorn's patch applied and resubmit patch for our new
> chip RTS5228 base on Bjorn's patch or ?

These are all now in my tree, so please feel free to resend any
outstanding patches against it.

But I think I have already applied your patch, right?

If not, please resend as I do not have anything outstanding that I can
see...

thanks,

greg k-h
