From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Add mmc_force_detect_change_begin / _end functions
Date: Mon, 22 Aug 2016 20:21:52 +0200
Message-ID: <CAPDyKFptVEjy8EQeL0t3xoxLvttHEJdvmmcS4k=8cuJbZEKTxA@mail.gmail.com>
References: <1470488736-11083-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFoTj9=esqaUPiwxLkhCsO98cSDgzdD1phgbXLa7rf6jiw@mail.gmail.com>
 <831381a3-7cca-1264-29e2-bd40802a815f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <831381a3-7cca-1264-29e2-bd40802a815f@redhat.com>
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

[...]

>
> This would also mean the driver's probe function does not end up
> getting called twice which certainly is better :)
>
> I'm not sure I'm familiar enough with the mmc subsys to come
> up with a good implementation of this though, nor when I'll have
> the time to look into this.
>
> Any chance you could make a RFC patch ? I can then test it on
> hardware which actually needs this and bug-fix the code until
> it actually works :)

Sure, I can do that! I keep you in the loop when I post it.

[...]

Kind regards
Uffe
