From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: Disable low power mode if SDIO interrupts
 are used
Date: Tue, 24 Jul 2012 09:58:42 -0700
Message-ID: <CAD=FV=Wa1bCRvLNnFjhht6nvNorm3CRzX5zrn-YDA2Jec1K3Eg@mail.gmail.com>
References: <CAD=FV=XuXUe1Jyd_urCzmS5+1vv7iuNTXYr23XYZp+MnTq1HGg@mail.gmail.com>
	<1343062955-24516-1-git-send-email-dianders@chromium.org>
	<500DFC34.8070205@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <500DFC34.8070205@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>, Olof Johansson <olofj@chromium.org>, shashidharh@vayavyalabs.com, ki0351.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 23, 2012 at 6:36 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> How about using "slot" instead of "mmc"?

Done.
