From: Olof Johansson <olof@lixom.net>
Subject: Re: dw_mmc: Does anyone use multiple slots?
Date: Thu, 8 Aug 2013 17:19:44 -0700
Message-ID: <CAOesGMjaF2K0CnuWBj7xdXGAQk-XRetBstaQdd9EZzBYrmDjeA@mail.gmail.com>
References: <CAD=FV=U3aT1KKtSwAFhYURJJerp70ij8h647=xyV51et4jYipg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=U3aT1KKtSwAFhYURJJerp70ij8h647=xyV51et4jYipg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: James Hogan <james.hogan@imgtec.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Tomasz Figa <tomasz.figa@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sonny Rao <sonnyrao@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 8, 2013 at 5:16 PM, Doug Anderson <dianders@google.com> wrote:

> I guess my overall question is: if there are no actual implementations
> of multislot, shouldn't we kill it and simplify the code a whole lot?
> If someone out there has a real multislot device they can step back in
> and do it more correctly?
>
> Of course we need to find someone to actually go through and do the
> killing of multislot, but finding that person might be easier if there
> was some agreement that it was good to do.

There clearly seems to be no in-tree users of multislot. If someone
new comes in, we have the code in the history and can revert the
removal (or at least use it as reference for re-introduction).

I vote for removing it. It adds really annoying complexity for
something that nobody uses.


-Olof
