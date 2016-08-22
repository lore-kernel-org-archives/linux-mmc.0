From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/5] mmc: sunxi: sun4i / sun5i do not have sample clocks
Date: Mon, 22 Aug 2016 15:38:09 +0200
Message-ID: <CAPDyKFrF77Jx2bHbWRRSf9nsakXedsM3mJ8oxUHxZoa4R76_PA@mail.gmail.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 30 July 2016 at 16:25, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Ulf, Maxime and Chen-Yu,
>
> Here is v2 of my patch set to deal with sun4i / sun5i not having
> mmc sample clocks, this time introducing a new sun7i-a20-mmc
> compatible for the models which do have sample clks, as discussed
> in the review of v1 of this set.
>
> Ulf, can you please add patches 1-4 to your tree for 4.9, and
> Maxime can you please pick up patch 5 ?
>
> Thanks & Regards,
>
> Hans

Thanks, applied for next!

Note that I picked the v2 of patch 5/5 and not the v3.

Kind regards
Uffe
