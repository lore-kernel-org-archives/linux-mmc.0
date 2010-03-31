From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [RFC] OMAP4-hsmmc: card-detect/regulator changes
Date: Wed, 31 Mar 2010 17:59:36 +0530
Message-ID: <s2z7f9d1ffb1003310529j6ead4a39wc9acbe7f71ae5f54@mail.gmail.com>
References: <h2p7f9d1ffb1003310451t85fbbb6eo3e3d06617a5a8f00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <h2p7f9d1ffb1003310451t85fbbb6eo3e3d06617a5a8f00@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@nokia.com, Madhusudhan <madhu.cr@ti.com>, jarkko.lavinen@nokia.com
List-Id: linux-mmc@vger.kernel.org

Small correction below

On Wed, Mar 31, 2010 at 5:21 PM, kishore kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> Hi,
> I am trying to implement card-detect and regulator changes for HSMMC
> driver on OMAP4.
>
> In OMAP4, hsmmc doesn't use any gpio line for card detect and instead
> uses interrupt line
> from TWL6030 which also provides a register for
> status[Inserted/removed] of the removable Card.
>
> Currently all the gpio related stuff moved from board file "hsmmc.c"
> to driver file "omap_hsmmc.c"
> [http://marc.info/?l=linux-mmc&m=126369200005981&w=2]and since the
> card-detect implementation
> for twl6030 uses I2c read/write it doesn't make sense to have the
   card-detect implementation in driver file.
   Does it make sense to have the gpio and non-gpio related stuff for
card detect
    in board file?
   Any suggestions appreciated.
>
> And the regulator changes can remain in driver file.
>
> Regards,
> Kishore
>
