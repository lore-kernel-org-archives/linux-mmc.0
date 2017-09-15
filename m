From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 1/3] mmc: describe new eMMC binding for fixed driver type
Date: Fri, 15 Sep 2017 13:18:52 -0500
Message-ID: <CAL_Jsq+X9R3R8CdHESyhRVj2P-nzF9i19viip1AFSOYgnw6A4w@mail.gmail.com>
References: <20170915180301.29175-1-wsa+renesas@sang-engineering.com> <20170915180301.29175-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170915180301.29175-2-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Needs to go to DT list and "dt-bindings: mmc: " is the preferred subject prefix.

On Fri, Sep 15, 2017 at 1:02 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Some boards may have to use a certain driver type (or drive strength) to
> achieve stable eMMC communication. Describe a binding to set this up via
> DT.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
>  1 file changed, 3 insertions(+)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
