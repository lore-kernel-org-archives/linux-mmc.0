From: Sasha Levin <sashal@kernel.org>
Subject: Re: [stable/4.14.y PATCH 0/3] mmc: Fix a potential resource leak
 when shutting down request queue.
Date: Mon, 13 May 2019 20:43:06 -0400
Message-ID: <20190514004306.GF11972@sasha-vm>
References: <20190513175521.84955-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190513175521.84955-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: stable@vger.kernel.org, linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Chris Boot <bootc@bootc.net>, =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 13, 2019 at 11:55:18AM -0600, Raul E Rangel wrote:
>I think we should cherry-pick 41e3efd07d5a02c80f503e29d755aa1bbb4245de
>https://lore.kernel.org/patchwork/patch/856512/ into 4.14. It fixes a
>potential resource leak when shutting down the request queue.
>
>Once this patch is applied, there is a potential for a null pointer dereference.
>That's what the second patch fixes.
>
>The third patch is just an optimization to stop processing earlier.

Is this actually part of a fix? Why do we want this optimization?

--
Thanks,
Sasha
