From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 5/5] mmc: dw_mmc: Set timeout to max upon resume
Date: Wed, 10 Jul 2013 23:54:52 +0900
Message-ID: <002b01ce7d7d$6eb717c0$4c254740$%jun@samsung.com>
References: <1373391071-6312-1-git-send-email-dianders@chromium.org>
 <1373411961-23812-1-git-send-email-dianders@chromium.org>
 <1373411961-23812-6-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1373411961-23812-6-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Olof Johansson' <olof@lixom.net>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, July 10, 2013, Doug Anderson wrote:
> The TMOUT register is initted to 0xffffffff at probe time but isn't
> initted after suspend/resume.  Add an init of this value.
> 
> No problems were observed without this (it will also get initted in
> __dw_mci_start_request if there is data to send), but it makes the
> register dump before and after suspend clean.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
