From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/2] Add support for Allwinner A64 mmc controller
Date: Fri, 9 Sep 2016 12:12:14 +0200
Message-ID: <CAPDyKFpqFm0zZvK_0gqSy9iuvRGS6MTs9i4OMPC6OVZ8AvjRgQ@mail.gmail.com>
References: <20160805025715.5306-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160805025715.5306-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Michal Suchanek <hramrach@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 5 August 2016 at 04:57, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Allwinner A64 has a slightly modified version of the Allwinner MMC controller.
>
> It do not have "output" or "sample" clock input, instead, it can calibrate the
> delay internally.
>
> This series of patch added the calibrate feature to the sunxi-mmc driver. It
> is based on works by Andre Przywara <andre.przywara@arm.com>, and now it
> depends on the patch set sent recently by Hans de Goede <hdegoede@redhat.com>,
> which disabled "output" and "sample" clock on A10/13.
> ( http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/446187.html )
>
> As the clock and device tree patch for Allwinner A64 is not yet merged, the
> patch set contains no patch to enable it.

Thanks, series applied for next!

Kind regards
Uffe
