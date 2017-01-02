From: Fabio Estevam <festevam@gmail.com>
Subject: Re: mmc: imx: 8-bit bus timeout (4.10-rc1)
Date: Mon, 2 Jan 2017 19:40:43 -0200
Message-ID: <CAOMZO5AgFM1T5XSZH3U5O6n+=_bi3eq7jS1XX9xTBS9Z+GwD9w@mail.gmail.com>
References: <20170102191508.ty7wr42pzxhhchaa@t450s.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34024 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755844AbdABVko (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2017 16:40:44 -0500
Received: by mail-oi0-f68.google.com with SMTP id 3so39102626oih.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2017 13:40:44 -0800 (PST)
In-Reply-To: <20170102191508.ty7wr42pzxhhchaa@t450s.lan>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Gary,

On Mon, Jan 2, 2017 at 5:15 PM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:

> Have you seen such behavior? Is the eMMC on the SABRE platform working
> fine?

Yes, just noticed the same on a mx6qsabresd.

I haven't had a chance to debug this yet.

If you could run a 'git bisect' that would be great. Thanks
