From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: Occasional crashes in suspend-resume with MMC transactions
Date: Thu, 22 Mar 2012 16:13:03 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317FFC59@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D12143317FDFBB@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317FF773@DBDE01.ent.ti.com>
 <CANfBPZ9b=6dLbY2D3oAg=Gz_vwAOJ+KC_Bo5ugVJEwumeej_Bw@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D12143317FFAC0@DBDE01.ent.ti.com>
 <CANfBPZ9AU+W7qP+uE2s2EnpzKhUqVQLdEgN=CUeNJZkSoh7+5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANfBPZ9AU+W7qP+uE2s2EnpzKhUqVQLdEgN=CUeNJZkSoh7+5A@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cjb@laptop.org" <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 22, 2012 at 21:36:36, S, Venkatraman wrote:
> On Thu, Mar 22, 2012 at 8:13 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> > On Thu, Mar 22, 2012 at 19:57:16, S, Venkatraman wrote:
> > [...]
> >>
> >> I see (in 3.3) that the host controller driver does a "return ret" and
> >> that means the errors is propagated.
> >> Where is the return code lost /overridden ?
> >>
> >
> > The return code gets overridden due to the call to host->pdata->resume()
> > which always returns 0.
> 
> Thanks - I see what you mean. But the patch is clunky.
> A clean fix would be to not capture the return code of resume() in
> "ret" and let the old
> value of ret be propagated as is.
> 

I agree. However, right now there's a dev_dbg() which checks for the return code.
I could change the host->pdata->resume() and host->pdata->suspend() to not return
anything if that's acceptable.

More importantly, is this the right fix or does the driver need some other fix
to make sure that such suspend failures do not occur at all?
