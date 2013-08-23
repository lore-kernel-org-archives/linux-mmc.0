From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 2/3] mmc: dw_mmc: Honor requests to set the clock to 0
 (turn off clock)
Date: Fri, 23 Aug 2013 13:40:52 -0700
Message-ID: <CAD=FV=WrZacm7UUB3-qE=ufwkur_55m0puPNdUaGBYszPw9OdQ@mail.gmail.com>
References: <1377188348-3418-1-git-send-email-dianders@chromium.org>
	<1377188348-3418-3-git-send-email-dianders@chromium.org>
	<521761F1.60203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <521761F1.60203@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Jaehoon,

On Fri, Aug 23, 2013 at 6:21 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Doug,
>
> If the clock-gating is enabled, then maybe it's continuously printed the kernel message for Bus_speed.

Can you explain?  I don't think dw_mmc has support for clock gating
right now.  ...or are there some patches that I'm not aware of?  I
could believe that if you've got some non-upstream clock gating
patches that these would need to be modified to handle it...  ...but
unless those are slated to land upstream it seems like I can't take
them into account, can I?

Thanks!

-Doug
